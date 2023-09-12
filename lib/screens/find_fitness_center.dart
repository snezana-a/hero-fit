import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class FindFitnessCenterScreen extends StatefulWidget {
  @override
  _FindFitnessCenterScreenState createState() =>
      _FindFitnessCenterScreenState();
}

class _FindFitnessCenterScreenState extends State<FindFitnessCenterScreen> {
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _locationData;
  GoogleMapController? mapController;
  Set<Marker> markers = <Marker>{};
  final TextEditingController _searchController = TextEditingController();
  bool _searchPerformed = false;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final location = Location();
    final serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      final serviceRequest = await location.requestService();
      if (!serviceRequest) {
        return;
      }
    }
    final permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      final permissionRequest = await location.requestPermission();
      if (permissionRequest != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    _updateMap(_locationData);

    location.onLocationChanged.listen((LocationData currentLocation) {
      _updateMap(currentLocation);
    });
  }

  Future<void> _checkLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    _updateMap(_locationData);

    location.onLocationChanged.listen((LocationData currentLocation) {
      _updateMap(currentLocation);
    });
  }

  void adjustCameraPosition(List<LatLng> locations) {
    if (locations.isNotEmpty) {
      double minLat = locations[0].latitude;
      double maxLat = locations[0].latitude;
      double minLng = locations[0].longitude;
      double maxLng = locations[0].longitude;

      for (LatLng location in locations) {
        if (location.latitude < minLat) minLat = location.latitude;
        if (location.latitude > maxLat) maxLat = location.latitude;
        if (location.longitude < minLng) minLng = location.longitude;
        if (location.longitude > maxLng) maxLng = location.longitude;
      }

      double centerLat = (minLat + maxLat) / 2;
      double centerLng = (minLng + maxLng) / 2;

      double zoom = calculateZoom(minLat, maxLat, minLng, maxLng);

      mapController?.moveCamera(
        CameraUpdate.newLatLngZoom(LatLng(centerLat, centerLng), zoom),
      );
    }
  }

  double calculateZoom(
      double minLat, double maxLat, double minLng, double maxLng) {
    const double padding = 100.0;
    const double minZoom = 4.0;

    double horizontalZoom =
        minZoom + ((log(360.0 / (maxLng - minLng)) / log(2)) - padding);
    double verticalZoom =
        minZoom + ((log(180.0 / (maxLat - minLat)) / log(2)) - padding);

    double zoom = min(horizontalZoom, verticalZoom);

    return zoom;
  }

  void _updateMap(LocationData? locationData) {
    if (locationData != null && !_searchPerformed) {
      final LatLng userLatLng =
          LatLng(locationData.latitude!, locationData.longitude!);

      Marker userLocationMarker = Marker(
        markerId: const MarkerId('user_location'),
        position: userLatLng,
        infoWindow: const InfoWindow(title: 'Your Location'),
      );

      setState(() {
        markers.add(userLocationMarker);
      });

      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(userLatLng, 14.0),
      );
    }
  }

  Future<void> _searchAndShowCityOnMap(String cityName) async {
    if (cityName.isNotEmpty) {
      List<geocoding.Location> locations =
          await geocoding.locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        geocoding.Location location = locations.first;

        setState(() {
          _searchPerformed = true;
        });

        Marker searchedLocationMarker = Marker(
          markerId: const MarkerId('searched_location'),
          position: LatLng(location.latitude, location.longitude),
          infoWindow: InfoWindow(title: cityName),
        );

        setState(() {
          markers.add(searchedLocationMarker);
        });

        adjustCameraPosition([LatLng(location.latitude, location.longitude)]);
      } else {
        setState(() {
          _showError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showError) {
      return const Center(
        child: Text('No location found for the given city name.'),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Map with Current Location'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter City Name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    String cityName = _searchController.text;
                    _searchAndShowCityOnMap(cityName);
                  },
                ),
              ),
            ),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(_locationData?.latitude ?? 0.0,
                      _locationData?.longitude ?? 0.0),
                  zoom: 14.0,
                ),
                markers: <Marker>{
                  Marker(
                    markerId: const MarkerId("user_location"),
                    position: LatLng(_locationData?.latitude ?? 0.0,
                        _locationData?.longitude ?? 0.0),
                    infoWindow: const InfoWindow(
                      title: "Your Location",
                    ),
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: FindFitnessCenterScreen(),
  ));
}

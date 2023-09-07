import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_fit/models/UserProfile.dart';
import 'package:image_picker/image_picker.dart';

import '../adapters/user_profile_adapter.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  XFile? _imageFile;
  UserProfile _userProfile = UserProfile(
    age: '',
    gender: '',
    weight: '',
    height: '',
    activityLevel: '',
    goal: '',
  );

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }
    try {
      final userData = await _firestore.collection('users').doc(user.uid).get();

      final userParams = userData.data() as Map<String, dynamic>;
      final userProfile = UserProfileAdapter.fromMap(userParams);

      setState(() {
        _userProfile = userProfile;
      });
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Widget _buildImage() {
    if (_imageFile == null) {
      return Image.asset(
        'assets/user.png',
        width: 150,
        height: 150,
      );
    } else {
      return Image.file(
        File(_imageFile!.path),
        width: 150,
        height: 150,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/background_1.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'assets/logo.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 171, 157),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildImage(),
                  const SizedBox(
                    width: 12.0,
                  ),
                ],
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text(
                      'Age: ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _userProfile.age,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text(
                      'Gender: ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _userProfile.gender,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text(
                      'Weight: ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _userProfile.weight,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text(
                      'Height: ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _userProfile.height,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text(
                      'Goal: ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _userProfile.goal,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text(
                      'Activity level: ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _userProfile.activityLevel,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 52.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Wrap(
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Gallery'),
                                onTap: () {
                                  _pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_camera),
                                title: const Text('Camera'),
                                onTap: () {
                                  _pickImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent,
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16.0)),
                    child: const Text('Change Profile Picture'),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent,
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16.0)),
                    onPressed: () {
                      Navigator.pushNamed(context, 'parameters_screen');
                    },
                    child: const Text(
                      'Change parameters',
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

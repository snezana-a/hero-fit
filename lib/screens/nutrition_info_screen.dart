import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    home: NutritionInfoScreen(),
  ));
}

class NutritionInfoScreen extends StatefulWidget {
  const NutritionInfoScreen({super.key});

  @override
  _NutritionInfoScreenState createState() => _NutritionInfoScreenState();
}

class _NutritionInfoScreenState extends State<NutritionInfoScreen> {
  final TextEditingController _foodNameController = TextEditingController();
  Map<String, dynamic> nutritionData = {};

  Future<void> fetchNutritionInfo(List<String> ingredients) async {
    const apiKey = '707d5b10e7bacdd1b1c044c78a38bfe4';
    const appId = '7a6a78d5';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      'title': 'nutrition-info',
      'ingr': ingredients,
    };

    final response = await http.post(
      Uri.parse(
          'https://api.edamam.com/api/nutrition-details?app_id=$appId&app_key=$apiKey'),
      headers: headers,
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      setState(() {
        nutritionData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load nutrition data');
    }
  }

  Widget buildNutrientRow(String label, String quantity, String unit) {
    return Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 16.0)),
            Flexible(
              child: Text(
                '$quantity $unit',
                style: const TextStyle(fontSize: 16.0),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Nutrition Info'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                final foodName = _foodNameController.text.trim();
                final ingredients =
                    foodName.split(',').map((e) => e.trim()).toList();
                if (ingredients.isNotEmpty) {
                  fetchNutritionInfo(ingredients);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 250,
                child: TextField(
                  controller: _foodNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter food name',
                  ),
                  onChanged: (value) {
                    // Handle text input
                  },
                  onSubmitted: (value) {
                    final foodName = _foodNameController.text.trim();
                    final ingredients =
                        foodName.split(',').map((e) => e.trim()).toList();
                    if (ingredients.isNotEmpty) {
                      fetchNutritionInfo(ingredients);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/background_1.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 76.0),
                  if (nutritionData.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yield: ${nutritionData['yield']}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          'Calories: ${nutritionData['calories']} kcal',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          'Total Weight: ${nutritionData['totalWeight']}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Total Nutrients (kcal)',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        buildNutrientRow(
                          'Energy',
                          nutritionData['totalNutrients']['ENERC_KCAL']
                                  ['quantity']
                              .toString(),
                          nutritionData['totalNutrients']['ENERC_KCAL']['unit'],
                        ),
                        buildNutrientRow(
                          nutritionData['totalNutrients']['FAT']['label'],
                          nutritionData['totalNutrients']['FAT']['quantity']
                              .toString(),
                          nutritionData['totalNutrients']['FAT']['unit'],
                        ),
                        buildNutrientRow(
                          nutritionData['totalNutrients']['CHOCDF']['label'],
                          nutritionData['totalNutrients']['CHOCDF']['quantity']
                              .toString(),
                          nutritionData['totalNutrients']['CHOCDF']['unit'],
                        ),
                        buildNutrientRow(
                          nutritionData['totalNutrients']['FIBTG']['label'],
                          nutritionData['totalNutrients']['FIBTG']['quantity']
                              .toString(),
                          nutritionData['totalNutrients']['FIBTG']['unit'],
                        ),
                        buildNutrientRow(
                          nutritionData['totalNutrients']['SUGAR']['label'],
                          nutritionData['totalNutrients']['SUGAR']['quantity']
                              .toString(),
                          nutritionData['totalNutrients']['SUGAR']['unit'],
                        ),
                        buildNutrientRow(
                          nutritionData['totalNutrients']['PROCNT']['label'],
                          nutritionData['totalNutrients']['PROCNT']['quantity']
                              .toString(),
                          nutritionData['totalNutrients']['PROCNT']['unit'],
                        ),
                        buildNutrientRow(
                          nutritionData['totalNutrients']['CHOLE']['label'],
                          nutritionData['totalNutrients']['CHOLE']['quantity']
                              .toString(),
                          nutritionData['totalNutrients']['CHOLE']['unit'],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ));
  }
}

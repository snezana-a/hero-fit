import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    home: ExercisesSearchScreen(),
  ));
}

class ExercisesSearchScreen extends StatefulWidget {
  const ExercisesSearchScreen({super.key});
  @override
  _ExercisesSearchScreenState createState() => _ExercisesSearchScreenState();
}

class _ExercisesSearchScreenState extends State<ExercisesSearchScreen> {
  final TextEditingController _searchExerciseController =
      TextEditingController();
  List<Map<String, dynamic>> exerciseData = []; // List of exercise items
  String exerciseOption = "muscle"; // Default option
  String searchQuery = "";
  Future<void> fetchExerciseInfo() async {
    const apiKey = 'ziuubc4D4YlEzM94jNVTXA==jfxaiFFOOSnqrWX8';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Api-Key': apiKey,
    };
    final response = await http.get(
      Uri.parse(
        'https://api.api-ninjas.com/v1/exercises?$exerciseOption=$searchQuery',
      ),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> exerciseList = json.decode(response.body);
      setState(() {
        exerciseData = List<Map<String, dynamic>>.from(exerciseList);
      });
    } else {
      throw Exception('Failed to load exercise data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<String>(
                    value: exerciseOption,
                    onChanged: (newValue) {
                      setState(() {
                        exerciseOption = newValue!;
                        print(exerciseOption);
                      });
                    },
                    items: ["muscle", "type", "difficulty"].map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          controller: _searchExerciseController,
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter exercise name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        fetchExerciseInfo();
                      },
                    ),
                  ],
                ),
                if (exerciseData.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: exerciseData.length,
                      itemBuilder: (context, index) {
                        final exercise = exerciseData[index];
                        final exerciseName = exercise["name"];
                        final exerciseType = exercise["type"];
                        final exerciseMuscle = exercise["muscle"];
                        final exerciseEquipment = exercise["equipment"];
                        final exerciseDifficulty = exercise["difficulty"];
                        final exerciseInstructions = exercise["instructions"];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$exerciseName",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              "Type: $exerciseType",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Muscle Worked: $exerciseMuscle",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Equipment: $exerciseEquipment",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Difficulty Level: $exerciseDifficulty",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              "Instructions: $exerciseInstructions",
                              style: const TextStyle(fontSize: 17),
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

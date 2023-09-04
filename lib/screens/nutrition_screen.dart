import 'package:flutter/material.dart';

import '../shared/MenuTile.dart';

// Abstract class for nutrition tiles
class NutritionScreen extends StatelessWidget {
  const NutritionScreen({Key? key});

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
                    'Nutrition',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 171, 157),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    FoodDiaryTile(
                      onPressed: () {
                        // Handle button tap
                      },
                    ),
                    RecipesTile(
                      onPressed: () {
                        Navigator.pushNamed(context, 'recipes_screen');
                      },
                    ),
                    NutritionInfoTile(
                      onPressed: () {
                        // Handle button tap
                      },
                    ),
                    CommunityTile(
                      onPressed: () {
                        // Handle button tap
                      },
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/people_exercising.png',
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void main() => runApp(const MaterialApp(home: NutritionScreen()));

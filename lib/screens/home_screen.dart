import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 66.0),
                Image.asset(
                  'assets/logo.png',
                  width: 130,
                  height: 130,
                ),
                const SizedBox(height: 100.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle button tap
                          },
                          icon: Image.asset(
                            'assets/barbell.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const Text(
                          'workouts',
                          style: TextStyle(
                              color: Color.fromARGB(255, 4, 171, 157)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle button tap
                          },
                          icon: Image.asset(
                            'assets/nutrition.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const Text(
                          'nutrition',
                          style: TextStyle(
                              color: Color.fromARGB(255, 4, 171, 157)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle button tap
                          },
                          icon: Image.asset(
                            'assets/settings.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const Text(
                          'settings',
                          style: TextStyle(
                              color: Color.fromARGB(255, 4, 171, 157)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle button tap
                          },
                          icon: Image.asset(
                            'assets/goal.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const Text(
                          'your progress',
                          style: TextStyle(
                              color: Color.fromARGB(255, 4, 171, 157)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 200.0),
                Image.asset(
                  'assets/people_exercising.png',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

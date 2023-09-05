import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                    'Settings',
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
                    _buildSettingsTile(
                      'assets/user.png',
                      'Your Profile',
                      () {
                        Navigator.pushNamed(context, 'your_profile_screen');
                      },
                    ),
                    const SizedBox(height: 10.0),
                    _buildSettingsTile(
                      'assets/smart-watch.png',
                      'Sync With Devices',
                      () {
                        // Handle button tap
                      },
                    ),
                    const SizedBox(height: 10.0),
                    _buildSettingsTile(
                      'assets/notification.png',
                      'Notifications',
                      () {
                        // Handle button tap
                      },
                    ),
                    const SizedBox(height: 10.0),
                    _buildSettingsTile(
                      'assets/slider.png',
                      'Adjust Parameters',
                      () {
                        // Handle button tap
                      },
                    ),
                    const SizedBox(height: 10.0),
                    _buildSettingsTile(
                      'assets/opinion.png',
                      'Feedback',
                      () {
                        // Handle button tap
                      },
                    ),
                    const SizedBox(height: 10.0),
                    _buildSettingsTile(
                      'assets/customer-service.png',
                      'Customer Support',
                      () {
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

  Widget _buildSettingsTile(
      String imagePath, String workoutName, Function() onPressed) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 80,
        height: 80,
      ),
      title: Text(workoutName,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.teal,
          )),
      onTap: onPressed,
    );
  }
}

void main() => runApp(const MaterialApp(home: SettingsScreen()));

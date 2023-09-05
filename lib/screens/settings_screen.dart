import 'package:flutter/material.dart';

import '../builders/custom_list_item_builder.dart';

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
                    CustomListItemBuilder()
                        .setText('Your Profile')
                        .setImagePath('assets/user.png')
                        .setOnPressed(() {
                      Navigator.pushNamed(context, 'your_profile_screen');
                    }).build(),
                    const SizedBox(height: 10.0),
                    CustomListItemBuilder()
                        .setText('Sync With Devices')
                        .setImagePath('assets/smart-watch.png')
                        .setOnPressed(() {}).build(),
                    const SizedBox(height: 10.0),
                    CustomListItemBuilder()
                        .setText('Notifications')
                        .setImagePath('assets/notification.png')
                        .setOnPressed(() {}).build(),
                    const SizedBox(height: 10.0),
                    CustomListItemBuilder()
                        .setText('Adjust Parameters')
                        .setImagePath('assets/slider.png')
                        .setOnPressed(() {}).build(),
                    const SizedBox(height: 10.0),
                    CustomListItemBuilder()
                        .setText('Feedback')
                        .setImagePath('assets/opinion.png')
                        .setOnPressed(() {}).build(),
                    const SizedBox(height: 10.0),
                    CustomListItemBuilder()
                        .setText('Customer Support')
                        .setImagePath('assets/customer-service.png')
                        .setOnPressed(() {}).build(),
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

void main() => runApp(const MaterialApp(home: SettingsScreen()));

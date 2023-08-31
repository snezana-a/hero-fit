import 'package:flutter/material.dart';

class ParametersScreen extends StatefulWidget {
  @override
  _ParametersScreenState createState() => _ParametersScreenState();
}

class _ParametersScreenState extends State<ParametersScreen> {
  String selectedActivityLevel = 'Light';
  String selectedGoal = 'Gain Weight';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background_welcome.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 100.0),
              Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 16.0,
              ),
              // Use custom text input fields with white background
              _buildCustomTextField('Age'),
              const SizedBox(
                height: 16.0,
              ),
              _buildCustomTextField('Gender'),
              const SizedBox(
                height: 16.0,
              ),
              _buildCustomTextField('Weight (kg)'),
              const SizedBox(
                height: 16.0,
              ),
              _buildCustomTextField('Height (cm)'),
              const SizedBox(height: 16.0),
              // Use custom dropdown button with white background
              _buildCustomDropdownButton(
                selectedActivityLevel,
                ['Light', 'Moderate', 'Intensive'],
                'Activity Level',
              ),
              const SizedBox(
                height: 16.0,
              ),
              _buildCustomDropdownButton(
                selectedGoal,
                ['Gain Weight', 'Lose Weight', 'Maintain Weight'],
                'Goal',
              ),
              const SizedBox(height: 16.0),
              // Use a custom white button with rounded corners
              _buildCustomButton('Continue'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextField(String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        // Add controller and validation as needed
      ),
    );
  }

  Widget _buildCustomDropdownButton(
      String value, List<String> items, String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: (String? newValue) {
          setState(() {
            value = newValue!;
          });
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }

  Widget _buildCustomButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Handle form submission here
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}

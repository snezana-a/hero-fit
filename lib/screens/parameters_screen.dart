import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ParametersScreen extends StatefulWidget {
  @override
  _ParametersScreenState createState() => _ParametersScreenState();
}

class _ParametersScreenState extends State<ParametersScreen> {
  String selectedActivityLevel = 'Light';
  String selectedGoal = 'Gain Weight';
  String selectedGender = 'Female';

  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  void _saveUserProfileDataToFirestore() async {
    try {
      final firestore = FirebaseFirestore.instance;

      String age = ageController.text;
      String weight = weightController.text;
      String height = heightController.text;

      Map<String, dynamic> userProfileData = {
        'age': age,
        'gender': selectedGender,
        'weight': weight,
        'height': height,
        'activityLevel': selectedActivityLevel,
        'goal': selectedGoal,
      };

      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        final userDocRef = firestore.collection('users').doc(currentUser.uid);

        await userDocRef.set(userProfileData);

        print('User profile data saved to Firestore');
      } else {
        print('User is not authenticated');
      }
    } catch (error) {
      print('Error saving user profile data: $error');
    }
  }

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_welcome.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 100.0),
              const SizedBox(height: 10.0),
              Image.asset(
                'assets/logo.png',
                width: 130,
                height: 130,
              ),
              const SizedBox(
                height: 10.0,
              ),
              _buildCustomTextField('Age', ageController),
              const SizedBox(
                height: 10.0,
              ),
              _buildCustomDropdownButton(selectedGender, ['Female', 'Male'],
                  'Gender', _handleGenderChange),
              const SizedBox(
                height: 10.0,
              ),
              _buildCustomTextField('Weight (kg)', weightController),
              const SizedBox(
                height: 10.0,
              ),
              const SizedBox(height: 16.0),
              _buildCustomTextField('Height (cm)', heightController),
              const SizedBox(height: 10.0),
              _buildCustomDropdownButton(
                  selectedActivityLevel,
                  ['Light', 'Moderate', 'Intensive'],
                  'Activity Level',
                  _handleActivityLevelChange),
              const SizedBox(
                height: 10.0,
              ),
              _buildCustomDropdownButton(
                  selectedGoal,
                  ['Gain Weight', 'Lose Weight', 'Maintain Weight'],
                  'Goal',
                  _handleGoalChange),
              const SizedBox(height: 16.0),
              const SizedBox(height: 10.0),
              _buildCustomButton('Continue'),
            ],
          ),
        ),
      ),
    );
  }

  void _handleActivityLevelChange(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedActivityLevel = newValue;
      });
    }
  }

  void _handleGoalChange(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedGoal = newValue;
      });
    }
  }

  void _handleGenderChange(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedGender = newValue;
      });
    }
  }

  Widget _buildCustomTextField(
      String labelText, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }

  Widget _buildCustomDropdownButton(
    String selectedValue,
    List<String> items,
    String labelText,
    Function(String?)? onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: onChanged,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCustomButton(String label) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, 'login_screen');
        _saveUserProfileDataToFirestore();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}

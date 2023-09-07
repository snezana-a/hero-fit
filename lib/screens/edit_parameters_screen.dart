import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_fit/screens/my_profile_screen.dart';

class EditParametersScreen extends StatefulWidget {
  const EditParametersScreen({Key? key}) : super(key: key);

  @override
  _EditParametersScreenState createState() => _EditParametersScreenState();
}

class _EditParametersScreenState extends State<EditParametersScreen> {
  String selectedActivityLevel = 'Light';
  String selectedGoal = 'Lose Weight';
  String selectedGender = 'Female';
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final userParams = userData.data() as Map<String, dynamic>;

        setState(() {
          _ageController.text = userParams['age'] ?? '';
          selectedGender = userParams['gender'] ?? '';
          _weightController.text = userParams['weight'] ?? '';
          _heightController.text = userParams['height'] ?? '';
          selectedActivityLevel = userParams['activityLevel'] ?? '';
          selectedGoal = userParams['goal'] ?? '';
        });
      } catch (e) {
        print('Error loading user data: $e');
      }
    }
  }

  void _saveChanges() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'age': _ageController.text,
        'gender': selectedGender,
        'weight': _weightController.text,
        'height': _heightController.text,
        'activityLevel': selectedActivityLevel,
        'goal': selectedGoal,
      });

      Navigator.pop(context); // Return to the MyProfileScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image.asset(
          'assets/background_1.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                width: 130,
                height: 130,
              ),
              const SizedBox(
                height: 10.0,
              ),
              _buildCustomTextField('Age', _ageController),
              const SizedBox(
                height: 10.0,
              ),
              _buildCustomDropdownButton(selectedGender, ['Female', 'Male'],
                  'Gender', _handleGenderChange),
              const SizedBox(
                height: 10.0,
              ),
              _buildCustomTextField('Weight (kg)', _weightController),
              const SizedBox(
                height: 10.0,
              ),
              _buildCustomTextField('Height (cm)', _heightController),
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
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.lightBlueAccent,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0)),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        )
      ],
    ));
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
}

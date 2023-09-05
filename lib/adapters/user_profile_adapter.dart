import '../models/UserProfile.dart';

class UserProfileAdapter {
  static UserProfile fromMap(Map<String, dynamic> data) {
    return UserProfile(
      age: data['age'] ?? '',
      gender: data['gender'] ?? '',
      weight: data['weight'] ?? '',
      height: data['height'] ?? '',
      activityLevel: data['activityLevel'] ?? '',
      goal: data['goal'] ?? '',
    );
  }
}
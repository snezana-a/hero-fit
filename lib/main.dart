import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hero_fit/screens/edit_parameters_screen.dart';
import 'package:hero_fit/screens/exercises_search_screen.dart';
import 'package:hero_fit/screens/find_fitness_center.dart';
import 'package:hero_fit/screens/home_screen.dart';
import 'package:hero_fit/screens/login_screen.dart';
import 'package:hero_fit/screens/nutrition_info_screen.dart';
import 'package:hero_fit/screens/nutrition_screen.dart';
import 'package:hero_fit/screens/parameters_screen.dart';
import 'package:hero_fit/screens/progress_screen.dart';
import 'package:hero_fit/screens/recipes_screen.dart';
import 'package:hero_fit/screens/registration_screen.dart';
import 'package:hero_fit/screens/settings_screen.dart';
import 'package:hero_fit/screens/welcome_screen.dart';
import 'package:hero_fit/screens/workouts_screen.dart';
import 'package:hero_fit/screens/my_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'registration_screen': (context) => const RegistrationScreen(),
        'login_screen': (context) => const LoginScreen(),
        'parameters_screen': (context) => ParametersScreen(),
        'home_screen': (context) => const HomeScreen(),
        'workouts_screen': (context) => WorkoutsScreen(),
        'nutrition_screen': (context) => const NutritionScreen(),
        'settings_screen': (context) => const SettingsScreen(),
        'progress_screen': (context) => const ProgressScreen(),
        'recipes_screen': (context) => RecipesScreen(),
        'my_profile_screen': (context) => const MyProfileScreen(),
        'nutrition_info_screen': (context) => const NutritionInfoScreen(),
        'edit_parameters_screen': (context) => const EditParametersScreen(),
        'find_fitness_center': (context) => FindFitnessCenterScreen(),
        'exercises_search_screen': (context) => const ExercisesSearchScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';

abstract class MenuTile extends StatelessWidget {
  final String imagePath;
  final String tileName;
  final Function() onPressed;

  MenuTile({
    required this.imagePath,
    required this.tileName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Image.asset(
            imagePath,
            width: 80,
            height: 80,
          ),
          title: Text(
            tileName,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.teal,
            ),
          ),
          onTap: onPressed,
        ),
        const SizedBox(height: 10.0), // SizedBox included here
      ],
    );
  }
}

// Concrete implementation for Food Diary nutrition tile
class FoodDiaryTile extends MenuTile {
  FoodDiaryTile({required Function() onPressed})
      : super(
          imagePath: 'assets/diary.png',
          tileName: 'Food Diary',
          onPressed: onPressed,
        );
}

// Concrete implementation for Recipes nutrition tile
class RecipesTile extends MenuTile {
  RecipesTile({required Function() onPressed})
      : super(
          imagePath: 'assets/recipe-book.png',
          tileName: 'Recipes',
          onPressed: onPressed,
        );
}

// Concrete implementation for Nutrition Info nutrition tile
class NutritionInfoTile extends MenuTile {
  NutritionInfoTile({required Function() onPressed})
      : super(
          imagePath: 'assets/salad.png',
          tileName: 'Nutrition Info',
          onPressed: onPressed,
        );
}

// Concrete implementation for Community nutrition tile
class CommunityTile extends MenuTile {
  CommunityTile({required Function() onPressed})
      : super(
          imagePath: 'assets/communities.png',
          tileName: 'Community',
          onPressed: onPressed,
        );
}

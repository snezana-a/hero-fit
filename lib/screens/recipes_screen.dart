import 'package:flutter/material.dart';
import 'package:hero_fit/screens/recipe_details_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipesScreen extends StatefulWidget {
  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  List<dynamic> recipes = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    const apiKey = '274267a207d6c3f58a57d4ed243e24db';
    const appId = '400b9f13';
    final response = await http.get(
      Uri.parse(
          'https://api.edamam.com/search?q=$query&app_id=$appId&app_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      setState(() {
        recipes = json.decode(response.body)['hits'];
      });
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Recipes'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                fetchRecipes();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 250,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search for recipes',
                  ),
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  onSubmitted: (value) {
                    fetchRecipes();
                  },
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/background_1.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                if (recipe != null && recipe['recipe'] != null) {
                  final recipeData = recipe['recipe'];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailsScreen(recipeData: recipeData),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.network(
                            recipeData['image'],
                            height: 200.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              recipeData['label'],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ));
  }
}

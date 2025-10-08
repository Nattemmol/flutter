import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class MealDbProvider {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Recipe>> searchRecipes(String query) async {
    final url = Uri.parse('$_baseUrl/search.php?s=$query');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((json) => _mapToRecipe(json)).toList();
    } else {
      throw Exception('Failed to fetch recipes from MealDB');
    }
  }

  Recipe _mapToRecipe(Map<String, dynamic> json) {
    return Recipe(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      description: json['strInstructions'] ?? '',
      imageUrl: json['strMealThumb'] ?? '',
      cuisine: json['strArea'] ?? '',
      tags: (json['strTags'] != null && json['strTags'].isNotEmpty)
          ? json['strTags'].split(',')
          : <String>[],
      prepTime: 0,
      cookTime: 0,
      servings: 1,
      difficulty: 'Medium',
      ingredients: _extractIngredients(json),
      instructions: (json['strInstructions'] ?? '').split('. '),
      nutritionInfo: NutritionInfo(
        calories: 0,
        protein: 0,
        carbohydrates: 0,
        fat: 0,
        fiber: 0,
        sugar: 0,
        sodium: 0,
      ),
      authorId: '',
      authorName: json['strSource'] ?? '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      rating: 0.0,
      reviewCount: 0,
      isVegetarian: false,
      isVegan: false,
      isGlutenFree: false,
    );
  }

  List<Ingredient> _extractIngredients(Map<String, dynamic> json) {
    final List<Ingredient> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final name = json['strIngredient$i'];
      final amount = json['strMeasure$i'];
      if (name != null && name.isNotEmpty) {
        ingredients.add(Ingredient(
          name: name,
          amount: 0,
          unit: amount ?? '',
          notes: null,
        ));
      }
    }
    return ingredients;
  }
}

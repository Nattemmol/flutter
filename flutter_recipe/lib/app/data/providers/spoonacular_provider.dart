import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import '../api_keys.dart';

class SpoonacularProvider {
  static const String _baseUrl = 'https://api.spoonacular.com/recipes';

  Future<List<Recipe>> searchRecipes(String query) async {
    // Step 1: Search for recipes (get IDs)
    final url = Uri.parse(
        '$_baseUrl/complexSearch?query=$query&number=10&addRecipeInformation=true&apiKey=${ApiKeys.spoonacular}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'] ?? [];
      // Step 2: For each recipe, fetch full info
      final List<Recipe> recipes = [];
      for (final jsonRecipe in results) {
        final id = jsonRecipe['id'];
        if (id != null) {
          final fullRecipe = await getRecipeInformation(id);
          if (fullRecipe != null) recipes.add(fullRecipe);
        }
      }
      return recipes;
    } else {
      throw Exception('Failed to fetch recipes from Spoonacular');
    }
  }

  Future<Recipe?> getRecipeInformation(dynamic id) async {
    final url = Uri.parse(
        '$_baseUrl/$id/information?includeNutrition=true&apiKey=${ApiKeys.spoonacular}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return _mapToRecipe(json);
    }
    return null;
  }

  Recipe _mapToRecipe(Map<String, dynamic> json) {
    // Nutrition mapping
    final nutrition = json['nutrition'] ?? {};
    double getNutrient(String name) {
      if (nutrition['nutrients'] is List) {
        final n = nutrition['nutrients'].firstWhere(
          (e) => e['name'] == name,
          orElse: () => null,
        );
        if (n != null && n['amount'] != null) {
          return (n['amount'] as num).toDouble();
        }
      }
      return 0.0;
    }

    return Recipe(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      description: json['summary'] ?? '',
      imageUrl: json['image'] ?? '',
      cuisine: (json['cuisines'] != null && json['cuisines'].isNotEmpty)
          ? json['cuisines'][0]
          : '',
      tags: json['diets'] != null
          ? List<String>.from((json['diets'] as List).map((e) => e.toString()))
          : <String>[],
      prepTime: json['preparationMinutes'] ?? 0,
      cookTime: json['cookingMinutes'] ?? 0,
      servings: json['servings'] ?? 1,
      difficulty: 'Medium',
      ingredients: (json['extendedIngredients'] as List?)
              ?.map((e) => Ingredient(
                    name: e['name'] ?? '',
                    amount: (e['amount'] ?? 0).toDouble(),
                    unit: e['unit'] ?? '',
                    notes: null,
                  ))
              .toList() ??
          [],
      instructions: (json['analyzedInstructions'] as List?)
              ?.expand((inst) =>
                  (inst['steps'] as List?)
                      ?.map((step) => step['step'] as String) ??
                  [])
              .toList() ??
          [],
      nutritionInfo: NutritionInfo(
        calories: getNutrient('Calories').toInt(),
        protein: getNutrient('Protein'),
        carbohydrates: getNutrient('Carbohydrates'),
        fat: getNutrient('Fat'),
        fiber: getNutrient('Fiber'),
        sugar: getNutrient('Sugar'),
        sodium: getNutrient('Sodium'),
      ),
      authorId: '',
      authorName: json['sourceName'] ?? '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      rating: (json['spoonacularScore'] ?? 0).toDouble(),
      reviewCount: 0,
      isVegetarian: (json['vegetarian'] ?? false),
      isVegan: (json['vegan'] ?? false),
      isGlutenFree: (json['glutenFree'] ?? false),
    );
  }
}

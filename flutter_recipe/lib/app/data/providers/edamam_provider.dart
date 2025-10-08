import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import '../api_keys.dart';

class EdamamProvider {
  static const String _baseUrl = 'https://api.edamam.com/search';

  Future<List<Recipe>> searchRecipes(String query) async {
    final url = Uri.parse(
        '$_baseUrl?q=$query&app_id=${ApiKeys.edamamAppId}&app_key=${ApiKeys.edamamAppKey}&to=10');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List hits = data['hits'] ?? [];
      return hits.map((hit) => _mapToRecipe(hit['recipe'])).toList();
    } else {
      throw Exception('Failed to fetch recipes from Edamam');
    }
  }

  Recipe _mapToRecipe(Map<String, dynamic> json) {
    return Recipe(
      id: json['uri'] ?? '',
      name: json['label'] ?? '',
      description: json['source'] ?? '',
      imageUrl: json['image'] ?? '',
      cuisine: (json['cuisineType'] != null && json['cuisineType'].isNotEmpty)
          ? json['cuisineType'][0]
          : '',
      tags: List<String>.from(json['dietLabels'] ?? []),
      prepTime: 0,
      cookTime: 0,
      servings: json['yield'] ?? 1,
      difficulty: 'Medium',
      ingredients: (json['ingredients'] as List?)
              ?.map((e) => Ingredient(
                    name: e['food'] ?? '',
                    amount: (e['quantity'] ?? 0).toDouble(),
                    unit: e['measure'] ?? '',
                    notes: null,
                  ))
              .toList() ??
          [],
      instructions: List<String>.from(json['ingredientLines'] ?? []),
      nutritionInfo: NutritionInfo(
        calories: (json['calories'] ?? 0).toInt(),
        protein:
            (json['totalNutrients']?['PROCNT']?['quantity'] ?? 0).toDouble(),
        carbohydrates:
            (json['totalNutrients']?['CHOCDF']?['quantity'] ?? 0).toDouble(),
        fat: (json['totalNutrients']?['FAT']?['quantity'] ?? 0).toDouble(),
        fiber: (json['totalNutrients']?['FIBTG']?['quantity'] ?? 0).toDouble(),
        sugar: (json['totalNutrients']?['SUGAR']?['quantity'] ?? 0).toDouble(),
        sodium: (json['totalNutrients']?['NA']?['quantity'] ?? 0).toDouble(),
      ),
      authorId: '',
      authorName: json['source'] ?? '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      rating: 0.0,
      reviewCount: 0,
      isVegetarian: (json['healthLabels'] ?? []).contains('Vegetarian'),
      isVegan: (json['healthLabels'] ?? []).contains('Vegan'),
      isGlutenFree: (json['healthLabels'] ?? []).contains('Gluten-Free'),
    );
  }
}

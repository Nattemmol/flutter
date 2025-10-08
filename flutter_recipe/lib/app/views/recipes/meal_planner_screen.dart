import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/recipe_controller.dart';
import '../../routes/app_routes.dart';
import '../widgets/recipe_card.dart';

class MealPlannerScreen extends StatefulWidget {
  const MealPlannerScreen({super.key});

  @override
  State<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> meals = ['Breakfast', 'Lunch', 'Dinner'];
  late Map<String, Map<String, String?>> mealPlan; // day -> meal -> recipeId

  @override
  void initState() {
    super.initState();
    mealPlan = {
      for (var d in days) d: {for (var m in meals) m: null}
    };
  }

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();
    final allRecipes = recipeController.displayedRecipes;
    final recommended = recipeController.getRecommendedRecipes();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Meal Planner'),
        backgroundColor: const Color(0xFF667eea),
      ),
      body: ListView.builder(
        itemCount: days.length,
        itemBuilder: (context, dayIdx) {
          final day = days[dayIdx];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(day,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...meals.map((meal) {
                    final recipeId = mealPlan[day]![meal];
                    final recipe =
                        allRecipes.firstWhereOrNull((r) => r.id == recipeId);
                    return Row(
                      children: [
                        Text(meal,
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(width: 8),
                        if (recipe != null)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                    '${AppRoutes.recipeDetail}?id=${recipe.id}');
                              },
                              child: RecipeCard(recipe: recipe, onTap: () {}),
                            ),
                          )
                        else
                          Expanded(
                            child: TextButton(
                              onPressed: () async {
                                // Suggest from recommended, fallback to all
                                final suggestions = recommended.isNotEmpty
                                    ? recommended
                                    : allRecipes;
                                final selected = await showDialog<String>(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                    title: Text('Select $meal for $day'),
                                    children: suggestions
                                        .take(10)
                                        .map((r) => SimpleDialogOption(
                                              onPressed: () =>
                                                  Navigator.pop(context, r.id),
                                              child: Text(r.name),
                                            ))
                                        .toList(),
                                  ),
                                );
                                if (selected != null) {
                                  setState(() {
                                    mealPlan[day]![meal] = selected;
                                  });
                                }
                              },
                              child: const Text('Add'),
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

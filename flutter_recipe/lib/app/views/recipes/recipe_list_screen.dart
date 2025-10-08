import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/recipe_controller.dart';
import '../../routes/app_routes.dart';
import '../widgets/recipe_card.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/providers/ingredient_recognition_service.dart';
import 'dart:io';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();
    final ScrollController scrollController = ScrollController();
    final stt.SpeechToText speech = stt.SpeechToText();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !recipeController.isLoading) {
        recipeController.loadNextPage();
      }
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'mealPlanner',
            backgroundColor: const Color(0xFF667eea),
            icon: const Icon(Icons.calendar_month),
            label: const Text('Meal Planner'),
            onPressed: () {
              Get.toNamed('/meal-planner');
            },
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'shoppingList',
            backgroundColor: const Color(0xFF667eea),
            icon: const Icon(Icons.shopping_cart),
            label: const Text('Shopping List'),
            onPressed: () {
              Get.toNamed('/shopping-list');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header section
              _buildHeader(recipeController),
              // Search and filter section
              _buildSearchAndFilter(recipeController),
              // Recommended section
              _buildRecommendedSection(recipeController),
              // Recipe list
              Expanded(
                child: _buildRecipeList(recipeController, scrollController),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(RecipeController recipeController) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recipe Master',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Obx(() => Text(
                    '${recipeController.displayedRecipes.length} recipes found',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  )),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    // TODO: Implement advanced search
                  },
                ),
              ),
              const SizedBox(width: 12),
              Builder(
                builder: (context) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(RecipeController recipeController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Search type segmented control
          Obx(() {
            final types = ['name', 'ingredient', 'cuisine'];
            final labels = ['Name', 'Ingredient', 'Cuisine'];
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(types.length, (i) {
                final selected = recipeController.searchType == types[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(labels[i]),
                    selected: selected,
                    onSelected: (_) => recipeController.setSearchType(types[i]),
                    selectedColor: const Color(0xFF667eea),
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            );
          }),
          const SizedBox(height: 12),
          // Search bar with autocomplete, image picker, and mic
          Row(
            children: [
              Expanded(
                  child: _buildSearchBarWithAutocomplete(recipeController)),
              const SizedBox(width: 8),
              _buildImagePickerButton(recipeController),
              const SizedBox(width: 8),
              _buildMicButton(recipeController),
            ],
          ),
          const SizedBox(height: 12),
          // Tag filter chips
          _buildTagFilterChips(recipeController),
          const SizedBox(height: 20),
          // Cuisine filter (existing)
          SizedBox(
            height: 50,
            child: Obx(() {
              final cuisines = recipeController.availableCuisines;
              final selectedCuisine = recipeController.selectedCuisine;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cuisines.length,
                itemBuilder: (context, index) {
                  final cuisine = cuisines[index];
                  final isSelected = selectedCuisine == cuisine;
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => recipeController.filterByCuisine(cuisine),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          cuisine,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF667eea)
                                : Colors.white,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSearchBarWithAutocomplete(RecipeController recipeController) {
    return Obx(() {
      final controller =
          TextEditingController(text: recipeController.searchQuery);
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
      return Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller,
                  onChanged: (val) => recipeController.searchRecipes(val),
                  decoration: InputDecoration(
                    hintText: 'Search recipes...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: Obx(() {
                      if (recipeController.searchQuery.isNotEmpty) {
                        return IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () => recipeController.searchRecipes(''),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                ),
              ),
              // Autocomplete dropdown
              if (_getAutocompleteSuggestions(recipeController).isNotEmpty &&
                  recipeController.searchQuery.isNotEmpty)
                Positioned(
                  left: 0,
                  right: 0,
                  top: 55,
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: _getAutocompleteSuggestions(recipeController)
                          .take(5)
                          .map((suggestion) => ListTile(
                                title: Text(suggestion),
                                onTap: () {
                                  recipeController.searchRecipes(suggestion);
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ),
            ],
          ),
        ],
      );
    });
  }

  List<String> _getAutocompleteSuggestions(RecipeController recipeController) {
    final query = recipeController.searchQuery.toLowerCase();
    final type = recipeController.searchType;
    final allRecipes = recipeController.displayedRecipes;
    final Set<String> suggestions = {};
    if (query.isEmpty) return [];
    if (type == 'name') {
      suggestions.addAll(allRecipes
          .map((r) => r.name)
          .where((name) => name.toLowerCase().contains(query)));
    } else if (type == 'ingredient') {
      for (final r in allRecipes) {
        suggestions.addAll(r.ingredients
            .map((i) => i.name)
            .where((name) => name.toLowerCase().contains(query)));
      }
    } else if (type == 'cuisine') {
      suggestions.addAll(allRecipes
          .map((r) => r.cuisine)
          .where((cuisine) => cuisine.toLowerCase().contains(query)));
    }
    return suggestions.toList();
  }

  Widget _buildTagFilterChips(RecipeController recipeController) {
    // Collect all unique tags from displayed recipes
    final Set<String> allTags = {};
    for (final recipe in recipeController.displayedRecipes) {
      allTags.addAll(recipe.tags);
    }
    final selectedTags = recipeController.selectedTags;
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allTags.map((tag) {
          final isSelected = selectedTags.contains(tag);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (selected) {
                final newTags = List<String>.from(selectedTags);
                if (selected) {
                  newTags.add(tag);
                } else {
                  newTags.remove(tag);
                }
                recipeController.setSelectedTags(newTags);
              },
              selectedColor: const Color(0xFF667eea),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildImagePickerButton(RecipeController recipeController) {
    return IconButton(
      icon: const Icon(Icons.camera_alt, color: Color(0xFF667eea)),
      tooltip: 'Scan ingredients from image',
      onPressed: () async {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          final service = IngredientRecognitionService();
          final ingredients =
              await service.recognizeIngredients(File(pickedFile.path));
          if (ingredients.isNotEmpty) {
            // Show dialog with detected ingredients and option to search
            Get.dialog(
              AlertDialog(
                title: const Text('Detected Ingredients'),
                content: SizedBox(
                  width: 300,
                  child: Wrap(
                    spacing: 8,
                    children: ingredients
                        .map((ing) => Chip(label: Text(ing)))
                        .toList(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      // Use the detected ingredients to search recipes
                      recipeController.searchRecipes(ingredients.join(", "));
                    },
                    child: const Text('Search Recipes'),
                  ),
                ],
              ),
            );
          } else {
            Get.snackbar('No Ingredients Found', 'Try another image.');
          }
        }
      },
    );
  }

  Widget _buildMicButton(RecipeController recipeController) {
    return Builder(
      builder: (context) {
        return IconButton(
          icon: const Icon(Icons.mic, color: Color(0xFF667eea)),
          tooltip: 'Voice Search',
          onPressed: () async {
            final stt.SpeechToText speech = stt.SpeechToText();
            bool available = await speech.initialize();
            if (available) {
              speech.listen(
                onResult: (result) {
                  final text = result.recognizedWords;
                  recipeController.searchRecipes(text);
                },
                listenFor: const Duration(seconds: 5),
                pauseFor: const Duration(seconds: 2),
                localeId: 'en_US',
                cancelOnError: true,
                partialResults: false,
              );
            } else {
              Get.snackbar(
                  'Mic Not Available', 'Speech recognition not available.');
            }
          },
        );
      },
    );
  }

  Widget _buildRecommendedSection(RecipeController recipeController) {
    final recommended = recipeController.getRecommendedRecipes();
    if (recommended.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recommended for You',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recommended.length > 5 ? 5 : recommended.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final recipe = recommended[index];
                return SizedBox(
                  width: 160,
                  child: RecipeCard(
                    recipe: recipe,
                    onTap: () {
                      Get.toNamed('${AppRoutes.recipeDetail}?id=${recipe.id}');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeList(
      RecipeController recipeController, ScrollController scrollController) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Obx(() {
        if (recipeController.isLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF667eea)),
                ),
                SizedBox(height: 16),
                Text(
                  'Loading recipes...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        if (recipeController.displayedRecipes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 80,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'No recipes found',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your search or filters',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: recipeController.clearFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF667eea),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Clear Filters'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => recipeController.refreshRecipes(),
          color: const Color(0xFF667eea),
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            itemCount: recipeController.displayedRecipes.length + 1,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index < recipeController.displayedRecipes.length) {
                final recipe = recipeController.displayedRecipes[index];
                return RecipeCard(
                  recipe: recipe,
                  onTap: () {
                    Get.toNamed('${AppRoutes.recipeDetail}?id=${recipe.id}');
                  },
                );
              } else {
                // Show loading indicator at the bottom if more data is being loaded
                return Obx(() => recipeController.isLoading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF667eea)),
                          ),
                        ),
                      )
                    : const SizedBox.shrink());
              }
            },
          ),
        );
      }),
    );
  }
}

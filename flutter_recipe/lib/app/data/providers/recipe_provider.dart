import 'package:get/get.dart';
import '../models/recipe.dart';
import '../mock/mock_recipes.dart';

class RecipeProvider extends GetxController {
  final RxList<Recipe> _allRecipes = <Recipe>[].obs;
  final RxList<Recipe> _filteredRecipes = <Recipe>[].obs;
  final RxString _selectedCuisine = 'All'.obs;
  final RxString _searchQuery = ''.obs;
  final RxBool _isLoading = false.obs;
  final RxString _searchType = 'name'.obs; // 'name', 'ingredient', 'cuisine'
  final RxList<String> _selectedTags = <String>[].obs;

  List<Recipe> get allRecipes => _allRecipes;
  List<Recipe> get filteredRecipes => _filteredRecipes;
  String get selectedCuisine => _selectedCuisine.value;
  String get searchQuery => _searchQuery.value;
  bool get isLoading => _isLoading.value;
  String get searchType => _searchType.value;
  List<String> get selectedTags => _selectedTags;
  List<String> get availableCuisines => MockRecipes.getCuisines();

  @override
  void onInit() {
    super.onInit();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    _isLoading.value = true;

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 1000));

    _allRecipes.value = MockRecipes.getRecipes();
    _filteredRecipes.value = _allRecipes;

    _isLoading.value = false;
  }

  void filterByCuisine(String cuisine) {
    _selectedCuisine.value = cuisine;
    _applyFilters();
  }

  void searchRecipes(String query) {
    _searchQuery.value = query;
    _applyFilters();
  }

  void setSearchType(String type) {
    _searchType.value = type;
    _applyFilters();
  }

  void setSelectedTags(List<String> tags) {
    _selectedTags.value = tags;
    _applyFilters();
  }

  void _applyFilters() {
    List<Recipe> filtered = _allRecipes;

    // Filter by cuisine
    if (_selectedCuisine.value != 'All') {
      filtered = filtered
          .where((recipe) => recipe.cuisine == _selectedCuisine.value)
          .toList();
    }

    // Filter by tags
    if (_selectedTags.isNotEmpty) {
      filtered = filtered
          .where((recipe) =>
              _selectedTags.every((tag) => recipe.tags.contains(tag)))
          .toList();
    }

    // Filter by search query and type
    if (_searchQuery.value.isNotEmpty) {
      final query = _searchQuery.value.toLowerCase();
      if (_searchType.value == 'name') {
        filtered = filtered
            .where((recipe) => recipe.name.toLowerCase().contains(query))
            .toList();
      } else if (_searchType.value == 'ingredient') {
        filtered = filtered
            .where((recipe) => recipe.ingredients
                .any((ing) => ing.name.toLowerCase().contains(query)))
            .toList();
      } else if (_searchType.value == 'cuisine') {
        filtered = filtered
            .where((recipe) => recipe.cuisine.toLowerCase().contains(query))
            .toList();
      } else {
        // fallback: search all
        filtered = filtered
            .where((recipe) =>
                recipe.name.toLowerCase().contains(query) ||
                recipe.description.toLowerCase().contains(query) ||
                recipe.tags.any((tag) => tag.toLowerCase().contains(query)))
            .toList();
      }
    }

    _filteredRecipes.value = filtered;
  }

  void clearFilters() {
    _selectedCuisine.value = 'All';
    _searchQuery.value = '';
    _filteredRecipes.value = _allRecipes;
  }

  Recipe? getRecipeById(String id) {
    try {
      return _allRecipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Recipe> getRecipesByCuisine(String cuisine) {
    return _allRecipes.where((recipe) => recipe.cuisine == cuisine).toList();
  }

  List<Recipe> getVegetarianRecipes() {
    return _allRecipes.where((recipe) => recipe.isVegetarian).toList();
  }

  List<Recipe> getQuickRecipes() {
    return _allRecipes.where((recipe) => recipe.totalTime <= 30).toList();
  }

  List<Recipe> getTopRatedRecipes() {
    List<Recipe> sorted = List.from(_allRecipes);
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(5).toList();
  }

  // Pagination: Get a page of filtered recipes
  List<Recipe> getRecipesPage(int page, int pageSize) {
    final start = page * pageSize;
    final end = (start + pageSize) > _filteredRecipes.length
        ? _filteredRecipes.length
        : (start + pageSize);
    if (start >= _filteredRecipes.length) return [];
    return _filteredRecipes.sublist(start, end);
  }
}

import 'package:get/get.dart';
import '../data/providers/recipe_provider.dart';
import '../data/providers/user_provider.dart';
import '../data/models/recipe.dart';

class RecipeController extends GetxController {
  final RecipeProvider _recipeProvider = Get.find();
  final UserProvider _userProvider = Get.find();

  final RxBool _isLoading = false.obs;
  final RxString _selectedCuisine = 'All'.obs;
  final RxString _searchQuery = ''.obs;
  final RxList<Recipe> _displayedRecipes = <Recipe>[].obs;
  final RxString _searchType = 'name'.obs; // 'name', 'ingredient', 'cuisine'
  final RxList<String> _selectedTags = <String>[].obs;

  final int _pageSize = 20;
  int _currentPage = 0;
  bool _isLoadingMore = false;

  bool get isLoading => _isLoading.value;
  String get selectedCuisine => _selectedCuisine.value;
  String get searchQuery => _searchQuery.value;
  String get searchType => _searchType.value;
  List<String> get selectedTags => _selectedTags;
  List<Recipe> get displayedRecipes => _displayedRecipes;
  List<String> get availableCuisines => _recipeProvider.availableCuisines;
  bool get isLoggedIn => _userProvider.isLoggedIn;

  @override
  void onInit() {
    super.onInit();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    _isLoading.value = true;
    await _recipeProvider.loadRecipes();
    _displayedRecipes.clear();
    _currentPage = 0;
    await loadNextPage();
    _isLoading.value = false;
  }

  Future<void> loadNextPage() async {
    if (_isLoadingMore || _isLoading.value) return;
    _isLoadingMore = true;
    final nextPage = _recipeProvider.getRecipesPage(_currentPage, _pageSize);
    if (nextPage.isNotEmpty) {
      _displayedRecipes.addAll(nextPage);
      _currentPage++;
    }
    _isLoadingMore = false;
  }

  void filterByCuisine(String cuisine) {
    _selectedCuisine.value = cuisine;
    _recipeProvider.filterByCuisine(cuisine);
    _displayedRecipes.clear();
    _currentPage = 0;
    loadNextPage();
  }

  void searchRecipes(String query) {
    _searchQuery.value = query;
    _recipeProvider.searchRecipes(query);
    _displayedRecipes.clear();
    _currentPage = 0;
    loadNextPage();
  }

  void clearFilters() {
    _selectedCuisine.value = 'All';
    _searchQuery.value = '';
    _recipeProvider.clearFilters();
    _displayedRecipes.clear();
    _currentPage = 0;
    loadNextPage();
  }

  void toggleFavorite(String recipeId) {
    if (_userProvider.isFavorite(recipeId)) {
      _userProvider.removeFromFavorites(recipeId);
    } else {
      _userProvider.addToFavorites(recipeId);
    }
  }

  void toggleSaved(String recipeId) {
    if (_userProvider.isSaved(recipeId)) {
      _userProvider.removeFromSaved(recipeId);
    } else {
      _userProvider.addToSaved(recipeId);
    }
  }

  bool isFavorite(String recipeId) {
    return _userProvider.isFavorite(recipeId);
  }

  bool isSaved(String recipeId) {
    return _userProvider.isSaved(recipeId);
  }

  Recipe? getRecipeById(String id) {
    return _recipeProvider.getRecipeById(id);
  }

  List<Recipe> getTopRatedRecipes() {
    return _recipeProvider.getTopRatedRecipes();
  }

  List<Recipe> getQuickRecipes() {
    return _recipeProvider.getQuickRecipes();
  }

  List<Recipe> getVegetarianRecipes() {
    return _recipeProvider.getVegetarianRecipes();
  }

  List<Recipe> getFavoriteRecipes() {
    return _recipeProvider.allRecipes
        .where((recipe) => _userProvider.isFavorite(recipe.id))
        .toList();
  }

  List<Recipe> getSavedRecipes() {
    return _recipeProvider.allRecipes
        .where((recipe) => _userProvider.isSaved(recipe.id))
        .toList();
  }

  // Personalized Recommendations
  List<Recipe> getRecommendedRecipes() {
    final allRecipes = _recipeProvider.allRecipes;
    final favoriteIds = _userProvider.favoriteRecipes;
    final favorites =
        allRecipes.where((r) => favoriteIds.contains(r.id)).toList();
    final dietaryRestrictions = _userProvider.getDietaryRestrictions();
    final preferredTime = _userProvider.getPreferredCookingTime();

    // Collect favorite tags, cuisines, ingredients
    final Set<String> favTags = favorites.expand((r) => r.tags).toSet();
    final Set<String> favCuisines = favorites.map((r) => r.cuisine).toSet();
    final Set<String> favIngredients =
        favorites.expand((r) => r.ingredients.map((i) => i.name)).toSet();

    // Score recipes
    List<MapEntry<Recipe, double>> scored =
        allRecipes.where((r) => !favoriteIds.contains(r.id)).map((recipe) {
      double score = 0;
      // Tag match
      score += recipe.tags.where((t) => favTags.contains(t)).length * 2;
      // Cuisine match
      if (favCuisines.contains(recipe.cuisine)) score += 2;
      // Ingredient match
      score += recipe.ingredients
              .where((i) => favIngredients.contains(i.name))
              .length *
          1.5;
      // Dietary restriction filter
      if (dietaryRestrictions.isNotEmpty &&
          !dietaryRestrictions.every((d) => recipe.tags.contains(d))) {
        score -= 1000; // Exclude
      }
      // Cooking time preference
      if (preferredTime != null) {
        final diff = (recipe.totalTime - preferredTime).abs();
        score -= diff / 10.0;
      }
      return MapEntry(recipe, score);
    }).toList();
    scored.sort((a, b) => b.value.compareTo(a.value));
    return scored.take(10).map((e) => e.key).toList();
  }

  void setSearchType(String type) {
    _searchType.value = type;
    if (_recipeProvider is dynamic &&
        (_recipeProvider as dynamic).setSearchType != null) {
      (_recipeProvider as dynamic).setSearchType(type);
    }
    _displayedRecipes.clear();
    _currentPage = 0;
    loadNextPage();
  }

  void setSelectedTags(List<String> tags) {
    _selectedTags.value = tags;
    if (_recipeProvider is dynamic &&
        (_recipeProvider as dynamic).setSelectedTags != null) {
      (_recipeProvider as dynamic).setSelectedTags(tags);
    }
    _displayedRecipes.clear();
    _currentPage = 0;
    loadNextPage();
  }

  Future<void> refreshRecipes() async {
    await _loadRecipes();
  }
}

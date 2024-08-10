import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_demo/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  //a the initial data
  FavoriteMealsNotifier() : super([]);

  //b the method to change initial data
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      //creates a new list without the specified meal and updates the state.
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      //copy the existing list, and then adding the new meal to the end.
      state = [...state, meal];
      return true;
    }
  }
}

//nb: statenotifierProvider work with class in pair which extend statenotifier
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});

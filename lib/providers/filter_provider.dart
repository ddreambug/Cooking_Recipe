import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_demo/providers/meal_provider.dart';

class FilterNotifier extends StateNotifier<Map<String, bool>> {
  FilterNotifier()
      : super({
          'Gluten-Free': false,
          'Vegan': false,
          'Vegetarian': false,
          'Lactose-Free': false,
        });

  void toggleFilter(String filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<String, bool>>((ref) {
  return FilterNotifier();
});

final filteredMealProvider = Provider(
  (ref) {
    final meals = ref.watch(mealsProvider);
    final selectedFilter = ref.watch(filterProvider);
    return meals.where((meal) {
      if (selectedFilter['Gluten-Free']! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilter['Vegan']! && !meal.isVegan) {
        return false;
      }
      if (selectedFilter['Vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilter['Lactose-Free']! && !meal.isLactoseFree) {
        return false;
      }
      return true;
    }).toList();
  },
);

import 'package:flutter/material.dart';
import 'package:navigation_demo/data/dummy_data.dart';
import 'package:navigation_demo/screen/meals.dart';
import 'package:navigation_demo/models/category.dart';
import 'package:navigation_demo/widget/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _changeScreen(BuildContext context, {required Category category}) {
    final filteredList = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Meals(
          title: category.title,
          meals: filteredList,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        //alt availableCategories.map((e) => CategoryGridItem(category: e)).toList()
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onChangeScreen: () {
              _changeScreen(context, category: category);
            },
          )
      ],
    );
  }
}

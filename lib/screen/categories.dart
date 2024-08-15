import 'package:flutter/material.dart';
import 'package:navigation_demo/data/dummy_data.dart';
import 'package:navigation_demo/models/meal.dart';
import 'package:navigation_demo/screen/meals.dart';
import 'package:navigation_demo/models/category.dart';
import 'package:navigation_demo/widget/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.filteredMeal,
  });

  final List<Meal> filteredMeal;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _changeScreen(BuildContext context, {required Category category}) {
    final availableMeals = widget.filteredMeal
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Meals(
          title: category.title,
          meals: availableMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        ),
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:navigation_demo/data/dummy_data.dart';
import 'package:navigation_demo/models/meal.dart';
import 'package:navigation_demo/screen/categories.dart';
import 'package:navigation_demo/screen/filter_screen.dart';
import 'package:navigation_demo/screen/meals.dart';
import 'package:navigation_demo/widget/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_demo/providers/meal_provider.dart';

Map<String, bool> kInitialFilter = {
  'Gluten-Free': false,
  'Vegan': false,
  'Vegetarian': false,
  'Lactose-Free': false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});
  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  Map<String, bool> _selectedFilter = kInitialFilter;

  int _selectedPageIndex = 0;
  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    // Navigate to filter screen and wait for a result
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<String, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );

      setState(() {
        _selectedFilter = result ?? kInitialFilter;
      });

      print(_selectedFilter);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    ));
  }

  //listing favourite meals
  final List<Meal> _favMeal = [];
  void _toggleFavourite(Meal meal) {
    setState(() {
      var isExisting = _favMeal.contains(meal);

      if (isExisting) {
        _favMeal.remove(meal);
        _showSnackbar('Removed from Favourite');
      } else {
        _favMeal.add(meal);
        _showSnackbar('Added to Favourite');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //get data from provider
    final meals = ref.watch(mealsProvider);
    //filter the meal based on filter value
    final filteredMeal = meals.where((meal) {
      if (_selectedFilter['Gluten-Free']! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter['Vegan']! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilter['Vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilter['Lactose-Free']! && !meal.isLactoseFree) {
        return false;
      }
      return true;
    }).toList();

    //navigating thru this 2 screen
    Widget activePage = CategoriesScreen(
      onToggledFavourite: _toggleFavourite,
      favMeal: _favMeal,
      filteredMeal: filteredMeal,
    );
    var activePageTitle = 'Pick Your Category';
    if (_selectedPageIndex == 1) {
      activePage = Meals(
        meals: _favMeal,
        onToggledFavourite: _toggleFavourite,
        favMeal: _favMeal,
      );
      activePageTitle = 'Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onTapDrawer: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourite',
          ),
        ],
      ),
    );
  }
}

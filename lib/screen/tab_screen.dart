import 'package:flutter/material.dart';
import 'package:navigation_demo/models/meal.dart';
import 'package:navigation_demo/screen/categories.dart';
import 'package:navigation_demo/screen/meals.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //listing favourite meals
  final List<Meal> _favMeal = [];
  void _toggleFavourite(Meal meal) {
    setState(() {
      var isExisting = _favMeal.contains(meal);

      if (isExisting) {
        _favMeal.remove(meal);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              const Text('Removed from Favourite', textAlign: TextAlign.center),
          duration: const Duration(seconds: 1),
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ));
      } else {
        _favMeal.add(meal);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              const Text('Added to Favourite', textAlign: TextAlign.center),
          duration: const Duration(seconds: 1),
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //navigating thru this 2 screen
    Widget activePage = CategoriesScreen(
      onToggledFavourite: _toggleFavourite,
      favMeal: _favMeal,
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

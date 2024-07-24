import 'package:flutter/material.dart';
import 'package:navigation_demo/models/meal.dart';
import 'package:navigation_demo/screen/categories.dart';
import 'package:navigation_demo/screen/filter_screen.dart';
import 'package:navigation_demo/screen/meals.dart';
import 'package:navigation_demo/widget/main_drawer.dart';

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

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<String, bool>>(
        MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        ),
      );
      print(result);
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

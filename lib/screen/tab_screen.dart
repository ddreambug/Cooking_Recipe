import 'package:flutter/material.dart';
import 'package:navigation_demo/providers/filter_provider.dart';
import 'package:navigation_demo/screen/categories.dart';
import 'package:navigation_demo/screen/filter_screen.dart';
import 'package:navigation_demo/screen/meals.dart';
import 'package:navigation_demo/widget/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_demo/providers/favorite_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    //filter the meal based on filter value
    final filteredMeal = ref.watch(filteredMealProvider);

    //navigating thru this 2 screen
    Widget activePage = CategoriesScreen(
      filteredMeal: filteredMeal,
    );
    var activePageTitle = 'Pick Your Category';
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = Meals(
        meals: favoriteMeals,
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

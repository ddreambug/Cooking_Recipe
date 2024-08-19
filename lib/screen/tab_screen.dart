import 'package:flutter/material.dart';
import 'package:navigation_demo/providers/filter_provider.dart';
import 'package:navigation_demo/screen/categories.dart';
import 'package:navigation_demo/screen/filter_screen.dart';
import 'package:navigation_demo/screen/meals.dart';
import 'package:navigation_demo/screen/new_meal.dart';
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
  int _selectedPageIndex = 0;
  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<String, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }

  void setNewItemScreen() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const NewMeal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeal = ref.watch(filteredMealProvider);
    var activePageTitle = 'Pick Your Category';
    Widget floatingAddItem = FloatingActionButton(
      onPressed: () {
        setNewItemScreen();
      },
      backgroundColor: const Color.fromARGB(153, 255, 105, 95),
      shape: const CircleBorder(),
      elevation: 10,
      tooltip: 'Add New Item',
      child: const Icon(Icons.add),
    );

    Widget activePage = CategoriesScreen(filteredMeal: filteredMeal);

    //bottomNavBar logic
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = Meals(meals: favoriteMeals);
      activePageTitle = 'Favourites';
      floatingAddItem = Container();
    }

    return Scaffold(
      floatingActionButton: floatingAddItem,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(title: Text(activePageTitle)),
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
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}

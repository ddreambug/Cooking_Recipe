import 'package:flutter/material.dart';
import 'package:navigation_demo/screen/categories.dart';
import 'package:navigation_demo/screen/meals.dart';
import 'package:navigation_demo/data/dummy_data.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        home:
            //const CategoriesScreen(),
            const Meals(title: 'Some Category..', meals: dummyMeals));
  }
}

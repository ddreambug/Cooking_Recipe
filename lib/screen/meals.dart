import 'package:flutter/material.dart';
import 'package:navigation_demo/models/meal.dart';
import 'package:navigation_demo/screen/meal_details.dart';
import 'package:navigation_demo/widget/meal_item.dart';

class Meals extends StatelessWidget {
  const Meals({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  void _showDetails(BuildContext context, {required Meal meal}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetail(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => MealItem(
        meal: meals[index],
        showDetails: () {
          _showDetails(context, meal: meals[index]);
        },
      ),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh Oh.. Nothing here!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Try Another Categories!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: content);
  }
}

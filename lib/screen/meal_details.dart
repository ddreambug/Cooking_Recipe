import 'package:flutter/material.dart';
import 'package:navigation_demo/models/meal.dart';

class MealDetail extends StatelessWidget {
  const MealDetail({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),
            Text('Ingredients',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),

            //cara 1, dengan for
            for (final ingredients in meal.ingredients)
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                  child: Text(ingredients)),
            const SizedBox(height: 15),
            Text('Steps',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
            //cara 2, dengan spread + map
            ...meal.steps.expand((steps) => [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                    child: Text(steps, textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 5)
                ]),
          ],
        ),
      ),
    );
  }
}

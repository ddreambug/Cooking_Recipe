import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_demo/models/meal.dart';
import 'package:navigation_demo/providers/favorite_provider.dart';

class MealDetail extends ConsumerWidget {
  const MealDetail({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var iconNotFavorite = Icons.star_border;
    var iconFavorite = Icons.star;
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isMealFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final isFavorite = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    isFavorite
                        ? 'Meal added as a Favorite'
                        : 'Meal removed from Favorite',
                    textAlign: TextAlign.center),
                duration: const Duration(seconds: 1),
                backgroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
              ));
            },
            icon: Icon(isMealFavorite ? iconFavorite : iconNotFavorite),
          )
        ],
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

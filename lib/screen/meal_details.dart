import 'package:flutter/material.dart';
import 'package:navigation_demo/models/meal.dart';

class MealDetail extends StatefulWidget {
  const MealDetail(
      {super.key,
      required this.meal,
      required this.onToggledFavourite,
      this.favMeal});

  final Meal meal;
  final void Function(Meal meal) onToggledFavourite;
  final List<Meal>? favMeal;

  @override
  State<MealDetail> createState() {
    return MealDetailState();
  }
}

class MealDetailState extends State<MealDetail> {
  @override
  Widget build(BuildContext context) {
    //derived from widget class, biar ga banyak ubah karena ini convert dari stateless ke stateful
    final meal = widget.meal;
    final favMeal = widget.favMeal;
    final void Function(Meal meal) onToggledFavourite =
        widget.onToggledFavourite;

    var appBarIcon = Icons.star_border;
    var favouriteStatus = favMeal!.contains(meal);
    if (favouriteStatus) {
      appBarIcon = Icons.star;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  onToggledFavourite(meal);
                });
              },
              icon: Icon(appBarIcon))
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

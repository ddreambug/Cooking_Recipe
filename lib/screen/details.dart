import 'package:flutter/material.dart';
import 'package:navigation_demo/models/meal.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Column(
        children: [
          Image.network(meal.imageUrl),
          Text(meal.id),
          Text(meal.title),
          Text(meal.affordability.name)
        ],
      ),
    );
  }
}

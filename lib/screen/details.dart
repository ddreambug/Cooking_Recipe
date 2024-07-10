import 'package:flutter/material.dart';
import 'package:navigation_demo/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.title, required this.meal});

  final String title;
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl)),
          Text(meal.id),
          Text(meal.title),
          Text(meal.affordability.name)
        ],
      ),
    );
  }
}

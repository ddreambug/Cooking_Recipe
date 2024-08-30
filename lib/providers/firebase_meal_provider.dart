import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_demo/models/meal.dart';
import 'package:http/http.dart' as http;

class FirebaseMealNotifier extends StateNotifier<List<Meal>> {
  FirebaseMealNotifier() : super([]);

  final url =
      Uri.https('meals-2f5aa-default-rtdb.firebaseio.com', 'meals.json');

  //add item to firebase
  void addNewItem(
      {required String title,
      required String imageUrl,
      required int duration,
      required Complexity complexity,
      required Affordability affordability,
      required List<String> ingredients,
      required List<String> steps,
      required Map<String, bool> categories}) async {
    http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'title': title,
          'imageUrl': imageUrl,
          'duration': duration,
          'complexity': complexity.name,
          'affordability': affordability.name,
          'ingredients': ingredients,
          'steps': steps,
          'categories': categories,
        },
      ),
    );

    //fetch items from firebase
    //delete item from firebase
  }
}

final firebaseMealProvider =
    StateNotifierProvider<FirebaseMealNotifier, List<Meal>>(
  (ref) {
    return FirebaseMealNotifier();
  },
);

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewMeal extends ConsumerStatefulWidget {
  const NewMeal({super.key});

  @override
  ConsumerState<NewMeal> createState() {
    return _NewMealState();
  }
}

class _NewMealState extends ConsumerState<NewMeal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('data'), Text('data')],
    );
  }
}

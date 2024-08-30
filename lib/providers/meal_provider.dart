import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_demo/data/dummy_data.dart';

final mealsProvider = Provider((ref) => dummyMeals);
//nb: using provider is enough for static items like dummymeals





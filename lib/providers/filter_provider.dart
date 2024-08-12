import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterNotifier extends StateNotifier<Map<String, bool>> {
  FilterNotifier()
      : super({
          'Gluten-Free': false,
          'Vegan': false,
          'Vegetarian': false,
          'Lactose-Free': false,
        });

  void toggleFilter(String filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<String, bool>>((ref) {
  return FilterNotifier();
});

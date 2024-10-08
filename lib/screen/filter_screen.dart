import 'package:flutter/material.dart';
import 'package:navigation_demo/widget/filter_property.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_demo/providers/filter_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultFilter = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // pop this screen and return value to tab_screen
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          Navigator.of(context).pop(defaultFilter);
        },
        child: Column(
          children: defaultFilter.keys.map((filter) {
            return FilterProperty(
              title: filter,
              subtitle: 'Only Include $filter Meal',
              filterValue: defaultFilter[filter]!,
            );
          }).toList(),
        ),
      ),
    );
  }
}

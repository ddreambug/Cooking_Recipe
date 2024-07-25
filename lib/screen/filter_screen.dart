import 'package:flutter/material.dart';
import 'package:navigation_demo/widget/filter_property.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  final Map<String, bool> _filters = {
    'Gluten-Free': false,
    'Vegan': false,
    'Vegetarian': false,
    'Lactose-Free': false,
  };

  void switchChanged(String switchTitle, bool switchValue) {
    setState(() {
      _filters[switchTitle] = switchValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // pop this screen and return value to tab_screen
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          Navigator.of(context).pop(_filters);
        },
        child: Column(
          children: _filters.keys.map((filter) {
            return FilterProperty(
                title: filter,
                subtitle: 'Only Include $filter Meal',
                filterValue: _filters[filter]!,
                onSwitchChanged: switchChanged);
          }).toList(),
        ),
      ),
    );
  }
}

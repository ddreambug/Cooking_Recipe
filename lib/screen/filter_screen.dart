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
  // var _glutenFreeFilterSet = false;
  // var _veganFilterSet = false;
  // var _vegetarianFilterSet = false;
  // var _LactoseFreeFilterSet = false;

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
      body: Column(
        children: _filters.keys.map((filter) {
          return FilterProperty(
              title: filter,
              subtitle: 'Only Include $filter Meal',
              filterValue: _filters[filter]!,
              onSwitchChanged: switchChanged);
        }).toList(),
        // children: [
        //   FilterProperty(
        //       title: 'Gluten-Free',
        //       subtitle: 'Only Include Gluten-Free Meal',
        //       filterValue: _glutenFreeFilterSet,
        //       onSwitchChanged: switchChanged),
        //   FilterProperty(
        //       title: 'Vegan',
        //       subtitle: 'Only Include Vegan Meal',
        //       filterValue: _veganFilterSet,
        //       onSwitchChanged: switchChanged),
        //   FilterProperty(
        //       title: 'Vegetarian',
        //       subtitle: 'Only Include Vegetarian Meal',
        //       filterValue: _vegetarianFilterSet,
        //       onSwitchChanged: switchChanged),
        //   FilterProperty(
        //       title: 'Lactose-Free',
        //       subtitle: 'Only Include Lactose-Free Meal',
        //       filterValue: _LactoseFreeFilterSet,
        //       onSwitchChanged: switchChanged)
        // ],
      ),
    );
  }
}

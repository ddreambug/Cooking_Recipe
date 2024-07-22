import 'package:flutter/material.dart';

class FilterProperty extends StatelessWidget {
  const FilterProperty({
    super.key,
    required this.title,
    required this.subtitle,
    required this.filterValue,
    required this.onSwitchChanged,
  });

  final void Function(String, bool) onSwitchChanged;
  final bool filterValue;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: filterValue,
      onChanged: (isSelected) {
        onSwitchChanged(title, isSelected);
      },
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 30, right: 30),
    );
  }
}

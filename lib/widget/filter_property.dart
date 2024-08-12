import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_demo/providers/filter_provider.dart';

class FilterProperty extends ConsumerWidget {
  const FilterProperty({
    super.key,
    required this.title,
    required this.subtitle,
    required this.filterValue,
  });

  final bool filterValue;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return SwitchListTile(
      value: filterValue,
      onChanged: (isSelected) =>
          ref.read(filterProvider.notifier).toggleFilter(title, isSelected),
      title: Text(
        title,
        style: theme.textTheme.titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.labelLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 30, right: 30),
    );
  }
}

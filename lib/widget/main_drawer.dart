import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onTapDrawer});

  final void Function(String identifier) onTapDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary.withOpacity(0.4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flatware,
                    size: 38,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                const SizedBox(width: 28),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w500,
                      fontSize: 28),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.fastfood,
              size: 20,
            ),
            title:
                Text('Meals', style: Theme.of(context).textTheme.titleLarge!),
            onTap: () {
              onTapDrawer('Meals');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.search,
              size: 20,
            ),
            title:
                Text('Filters', style: Theme.of(context).textTheme.titleLarge!),
            onTap: () {
              onTapDrawer('Filters');
            },
          ),
        ],
      ),
    );
  }
}

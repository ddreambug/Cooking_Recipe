import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Navigation'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: const [
          Text('1',
              style: TextStyle(color: Color.fromARGB(255, 255, 252, 243))),
          Text('2',
              style: TextStyle(color: Color.fromARGB(255, 255, 252, 243))),
          Text('3',
              style: TextStyle(color: Color.fromARGB(255, 255, 252, 243))),
          Text('4',
              style: TextStyle(color: Color.fromARGB(255, 255, 252, 243))),
          Text('5',
              style: TextStyle(color: Color.fromARGB(255, 255, 252, 243))),
          Text('6',
              style: TextStyle(color: Color.fromARGB(255, 255, 252, 243))),
        ],
      ),
    );
  }
}

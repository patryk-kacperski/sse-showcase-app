import 'package:flutter/material.dart';
import 'examples.dart';

class ExamplesListScreen extends StatelessWidget {
  const ExamplesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSE Examples'),
      ),
      body: ListView.builder(
        itemCount: Examples.values.length,
        itemBuilder: (context, index) {
          final example = Examples.values[index];
          return ListTile(
            title: Text(example.name),
          );
        },
      ),
    );
  }
}

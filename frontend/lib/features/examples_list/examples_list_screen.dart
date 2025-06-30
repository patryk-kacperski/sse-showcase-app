import 'package:flutter/material.dart';
import 'package:sse_showcase/features/examples/standard_http/standard_http_example_screen.dart';
import 'examples.dart';

class ExamplesListScreen extends StatelessWidget {
  const ExamplesListScreen({super.key});

  void _onExampleTap(BuildContext context, Examples example) {
    switch (example) {
      case Examples.standardHttp:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const StandardHttpExampleScreen(),
          ),
        );
    }
  }

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
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _onExampleTap(context, example),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sse_showcase/features/examples/lorem_ipsum/lorem_ipsum_screen.dart';
import 'package:sse_showcase/features/examples/standard_http/standard_http_example_screen.dart';
import 'package:sse_showcase/features/examples/standard_http2/standard_http_example_screen.dart';
import 'package:sse_showcase/widgets/standard_app_bar.dart';
import 'package:sse_showcase/widgets/standard_list_tile.dart';
import 'examples.dart';

class ExamplesListScreen extends StatelessWidget {
  const ExamplesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onExampleTap(Examples example) {
      switch (example) {
        case Examples.standardHttp:
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const StandardHttpExampleScreen(),
            ),
          );
        case Examples.standardHttp2:
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const StandardHttpExampleScreen2(),
            ),
          );
        case Examples.loremIpsum:
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoremIpsumScreen()),
          );
      }
    }

    return Scaffold(
      appBar: const StandardAppBar(title: 'SSE Examples'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: Examples.values.length,
        itemBuilder: (context, index) {
          final example = Examples.values[index];
          return StandardListTile(
            title: Text(example.name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onExampleTap(example),
          );
        },
      ),
    );
  }
}

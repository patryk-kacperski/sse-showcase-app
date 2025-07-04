import 'package:flutter/material.dart';
import 'package:sse_showcase/features/examples_list/examples_list_screen.dart';
import 'package:sse_showcase/global_dependencies.dart';

class SseShowcaseApp extends StatelessWidget {
  const SseShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalDependencies(
      child: MaterialApp(
        title: 'SSE Showcase',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const ExamplesListScreen(),
      ),
    );
  }
}

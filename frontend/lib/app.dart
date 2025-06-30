import 'package:flutter/material.dart';
import 'features/examples_list/examples_list_screen.dart';

class SseShowcaseApp extends StatelessWidget {
  const SseShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSE Showcase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExamplesListScreen(),
    );
  }
}

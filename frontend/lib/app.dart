import 'package:flutter/material.dart';
import 'package:sse_showcase/features/clients/clients_screen.dart';

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
      home: const ClientsScreen(),
    );
  }
}

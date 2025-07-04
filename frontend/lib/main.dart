import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'global_dependencies.dart';

void main() {
  runApp(
    MultiProvider(
      providers: createGlobalDependencies(),
      child: const SseShowcaseApp(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';

class GlobalDependencies extends StatelessWidget {
  const GlobalDependencies({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(
          create: (_) => http.Client(),
          dispose: (_, client) => client.close(),
        ),
        Provider<SseService>(
          create: (context) => SseService(context.read<http.Client>()),
        ),
      ],
      child: child,
    );
  }
}

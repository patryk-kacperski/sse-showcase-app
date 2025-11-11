import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';
import 'package:sse_showcase/utils/sse_client/sse_client.dart';
import 'package:sse_showcase/utils/sse_client/sse_simple_client.dart';

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
        Provider<SseClient>(
          create: (context) => SseSimpleClient(context.read<http.Client>()),
        ),
        Provider<SseService>(
          create: (context) => SseService(context.read<SseClient>()),
        ),
      ],
      child: child,
    );
  }
}

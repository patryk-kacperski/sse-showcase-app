import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sse_showcase/features/clients/clients.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';
import 'package:sse_showcase/utils/sse_client/eventflux_client.dart';
import 'package:sse_showcase/utils/sse_client/flutter_client_sse.dart';
import 'package:sse_showcase/utils/sse_client/sse_client.dart';
import 'package:sse_showcase/utils/sse_client/sse_simple_client.dart';

class ClientDependencies extends StatelessWidget {
  const ClientDependencies({
    super.key,
    required this.client,
    required this.child,
  });

  final Clients client;
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
          create: (context) {
            switch (client) {
              case Clients.simple:
                return SseSimpleClient(context.read<http.Client>());
              case Clients.flutterClientSse:
                return FlutterClientSse();
              case Clients.eventflux:
                return EventfluxClient();
            }
          },
        ),
        Provider<SseService>(
          create: (context) => SseService(context.read<SseClient>()),
        ),
      ],
      child: child,
    );
  }
}

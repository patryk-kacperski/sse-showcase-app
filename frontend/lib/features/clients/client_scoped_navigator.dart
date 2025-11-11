import 'package:flutter/material.dart';
import 'package:sse_showcase/features/clients/client_dependencies.dart';
import 'package:sse_showcase/features/clients/clients.dart';
import 'package:sse_showcase/features/examples_list/examples_list_screen.dart';

class ClientScopedNavigator extends StatelessWidget {
  const ClientScopedNavigator({super.key, required this.client});

  final Clients client;

  @override
  Widget build(BuildContext context) {
    return ClientDependencies(
      client: client,
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const ExamplesListScreen(),
            settings: settings,
          );
        },
      ),
    );
  }
}

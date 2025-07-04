import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';

List<Provider> createGlobalDependencies() {
  return [
    Provider<http.Client>(
      create: (_) => http.Client(),
      dispose: (_, client) => client.close(),
    ),
    Provider<SseService>(
      create: (context) => SseService(context.read<http.Client>()),
    ),
  ];
}

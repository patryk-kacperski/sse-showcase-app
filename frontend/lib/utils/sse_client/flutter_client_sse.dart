import 'package:collection/collection.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:http/http.dart' as http;
import 'package:sse_showcase/models/api/sse_event.dart';
import 'package:sse_showcase/utils/sse_client/sse_client.dart';

/// An implementation of the SseClient interface that uses the flutter_client_sse package.
class FlutterClientSse implements SseClient {
  @override
  Stream<SseEvent> stream(http.Request request) async* {
    final method = SSERequestType.values.firstWhereOrNull(
      (e) => e.name == request.method.toUpperCase(),
    );
    if (method == null) {
      throw Exception('Invalid method: ${request.method}');
    }
    final url = request.url.toString();
    final header = request.headers;
    final body = request.bodyBytes.isNotEmpty ? request.bodyFields : null;

    yield* SSEClient.subscribeToSSE(
      method: method,
      url: url,
      header: header,
      body: body,
    ).map(
      (model) => SseEvent(
        event: model.event ?? '',
        data: model.data ?? '',
        id: model.id,
      ),
    );
  }
}

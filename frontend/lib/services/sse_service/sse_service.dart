import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sse_showcase/utils/api.dart';
import 'package:sse_showcase/models/api/sse_event.dart';

class SseService {
  SseService(this._client);

  final http.Client _client;

  Stream<SseEvent> streamNumbers() async* {
    final request = createNumbersRequest();
    yield* _stream(request);
  }

  Stream<SseEvent> streamLoremIpsum() async* {
    final request = createTextStreamRequest();
    yield* _stream(request);
  }

  Stream<SseEvent> _stream(http.Request request) async* {
    try {
      final response = await _client.send(request);

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to connect to SSE endpoint: ${response.statusCode}',
        );
      }

      await for (final chunk in response.stream.transform(utf8.decoder)) {
        final eventData = chunk.trim();

        if (eventData.isNotEmpty) {
          yield SseEvent.fromRawData(eventData);
        }
      }
    } catch (error) {
      throw Exception('SSE streaming error: $error');
    }
  }
}

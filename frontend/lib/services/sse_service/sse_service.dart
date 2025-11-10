import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sse_showcase/models/api/sse_event_builder.dart';
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

  Stream<SseEvent> streamShapesAndColors() async* {
    final request = createShapesAndColorsRequest();
    yield* _stream(request);
  }

  Stream<SseEvent> streamWikimediaRecentChanges() async* {
    final request = createWikimediaRecentChangesRequest();
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

      var eventBuilder = SseEventBuilder();

      await for (final chunk in response.stream.transform(utf8.decoder)) {
        final lines = chunk.split('\n');

        for (final line in lines) {
          if (line.isEmpty) {
            final event = eventBuilder.build();
            if (event != null) {
              yield event;
            }
            eventBuilder = SseEventBuilder();
          }

          final isComment = line.startsWith(':');
          if (isComment) {
            continue;
          }

          eventBuilder.addLine(line);
        }
      }
    } catch (error) {
      throw Exception('SSE streaming error: $error');
    }
  }
}

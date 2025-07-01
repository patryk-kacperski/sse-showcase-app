import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sse_showcase/models/api/number_data.dart';
import 'package:sse_showcase/models/api/sse_event.dart';

class SseService {
  static const String _baseUrl = 'http://localhost:5080';
  static const String _numbersEndpoint = '/numbers';

  Stream<NumberData> streamNumbers() async* {
    final client = http.Client();

    try {
      final request =
          http.Request('GET', Uri.parse('$_baseUrl$_numbersEndpoint'));
      request.headers['Accept'] = 'text/event-stream';
      request.headers['Cache-Control'] = 'no-cache';

      final response = await client.send(request);

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to connect to SSE endpoint: ${response.statusCode}');
      }

      final streamController = StreamController<String>();
      String buffer = '';

      response.stream.transform(utf8.decoder).listen(
        (data) {
          buffer += data;
          final lines = buffer.split('\n');

          // Keep the last incomplete line in the buffer
          buffer = lines.removeLast();

          for (final line in lines) {
            if (line.trim().isNotEmpty) {
              streamController.add(line);
            }
          }
        },
        onError: (error) {
          streamController.addError(error);
        },
        onDone: () {
          if (buffer.trim().isNotEmpty) {
            streamController.add(buffer);
          }
          streamController.close();
        },
      );

      String eventBuffer = '';

      await for (final line in streamController.stream) {
        if (line.isEmpty) {
          if (eventBuffer.isNotEmpty) {
            try {
              final sseEvent = SseEvent.fromRawData(eventBuffer);
              if (sseEvent.event == 'numbers' && sseEvent.data.isNotEmpty) {
                yield NumberData.fromString(sseEvent.data);
              }
            } catch (e) {
              // Skip malformed events
            }
            eventBuffer = '';
          }
        } else {
          eventBuffer += '$line\n';
        }
      }

      // Process any remaining event in buffer
      if (eventBuffer.isNotEmpty) {
        try {
          final sseEvent = SseEvent.fromRawData(eventBuffer);
          if (sseEvent.event == 'numbers' && sseEvent.data.isNotEmpty) {
            yield NumberData.fromString(sseEvent.data);
          }
        } catch (e) {
          // Skip malformed events
        }
      }
    } catch (error) {
      throw Exception('SSE streaming error: $error');
    } finally {
      client.close();
    }
  }
}

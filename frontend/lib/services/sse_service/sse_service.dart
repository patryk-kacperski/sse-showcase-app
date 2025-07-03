import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sse_showcase/utils/api.dart';
import 'package:sse_showcase/models/api/number_data.dart';
import 'package:sse_showcase/models/api/sse_event.dart';

class SseService {
  Stream<NumberData> streamNumbers() async* {
    final client = http.Client();

    try {
      final request = createNumbersRequest();

      final response = await client.send(request);

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to connect to SSE endpoint: ${response.statusCode}',
        );
      }

      String buffer = '';

      await for (final chunk in response.stream.transform(utf8.decoder)) {
        buffer += chunk;

        // Process complete events (separated by double newline)
        while (buffer.contains('\n\n')) {
          final eventEndIndex = buffer.indexOf('\n\n');
          final eventData = buffer.substring(0, eventEndIndex);
          buffer = buffer.substring(eventEndIndex + 2);

          if (eventData.trim().isNotEmpty) {
            try {
              final sseEvent = SseEvent.fromRawData(eventData);

              if (sseEvent.event == 'numbers' && sseEvent.data.isNotEmpty) {
                yield NumberData.fromString(sseEvent.data);
              }
            } catch (e) {
              // Skip malformed events
            }
          }
        }
      }

      // Process any remaining event in buffer
      if (buffer.trim().isNotEmpty) {
        try {
          final sseEvent = SseEvent.fromRawData(buffer);
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

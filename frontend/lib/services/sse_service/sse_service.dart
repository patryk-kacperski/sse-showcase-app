import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sse_showcase/utils/api.dart';
import 'package:sse_showcase/models/api/sse_event.dart';
import 'package:sse_showcase/utils/sse_client/sse_client.dart';

class SseService {
  SseService(this._client);

  final SseClient _client;

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

  Stream<SseEvent> _stream(http.Request request) => _client.stream(request);
}

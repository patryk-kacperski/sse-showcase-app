import 'package:http/http.dart' as http;
import 'package:sse_showcase/models/api/sse_event.dart';

abstract interface class SseClient {
  Stream<SseEvent> stream(http.Request request);
}

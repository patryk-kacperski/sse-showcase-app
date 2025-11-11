import 'package:http/http.dart' as http;
import 'package:sse_channel/sse_channel.dart';
import 'package:sse_showcase/models/api/sse_event.dart';
import 'package:sse_showcase/utils/sse_client/sse_client.dart';

class SseChannelClient implements SseClient {
  @override
  Stream<SseEvent> stream(http.Request request) async* {
    final channel = SseChannel.connect(request.url);

    await channel.ready;

    yield* channel.stream.map(
      (event) => SseEvent(
        event: event.event ?? '',
        data: event.data ?? '',
        id: event.id,
      ),
    );
  }
}

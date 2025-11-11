import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eventflux/eventflux.dart';
import 'package:http/http.dart' as http;
import 'package:sse_showcase/models/api/sse_event.dart';
import 'package:sse_showcase/utils/sse_client/sse_client.dart';

class EventfluxClient implements SseClient {
  @override
  Stream<SseEvent> stream(http.Request request) {
    final controller = StreamController<SseEvent>();
    final eventflux = EventFlux.spawn();

    final connectionType = EventFluxConnectionType.values.firstWhereOrNull(
      (e) => e.name == request.method.toLowerCase(),
    );

    if (connectionType == null) {
      controller.addError(Exception('Invalid method: ${request.method}'));
      controller.close();
      return controller.stream;
    }

    final url = request.url.toString();
    eventflux.connect(
      connectionType,
      url,
      header: request.headers,
      onSuccessCallback: (EventFluxResponse? response) {
        final stream = response?.stream;
        if (stream == null) {
          controller.close();
          return;
        }

        stream.listen(
          (EventFluxData data) {
            controller.add(
              SseEvent(event: data.event, data: data.data, id: data.id),
            );
          },
          onError: controller.addError,
          onDone: controller.close,
          cancelOnError: false,
        );
      },
      onError: (error) {
        controller.addError(error);
        controller.close();
      },
    );

    return controller.stream;
  }
}

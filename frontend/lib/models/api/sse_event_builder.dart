import 'package:sse_showcase/models/api/sse_event.dart';

class SseEventBuilder {
  SseEventBuilder();

  String? event;
  String? data;
  String? id;

  SseEvent? build() {
    final event = this.event;
    final data = this.data;

    if (event == null || data == null) {
      return null;
    }

    return SseEvent(event: event, data: data, id: id);
  }

  void addLine(String line) {
    if (line.startsWith('event:')) {
      event = line.substring('event:'.length).trim();
    } else if (line.startsWith('data:')) {
      final value = line.substring('data:'.length).trim();
      if (data == null) {
        data = value;
      } else {
        data = '$data\n$value';
      }
    } else if (line.startsWith('id:')) {
      final value = line.substring('id:'.length).trim();
      if (value.isEmpty) {
        return;
      }
      id = value;
    }
  }
}

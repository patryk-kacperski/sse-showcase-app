import 'package:equatable/equatable.dart';

class SseEvent extends Equatable {
  const SseEvent({required this.event, required this.data});

  factory SseEvent.fromRawData(String rawData) {
    final lines = rawData.split('\n');
    String event = '';
    String data = '';

    for (final line in lines) {
      if (line.startsWith('event: ')) {
        event = line.substring('event: '.length);
      } else if (line.startsWith('data: ')) {
        data = line.substring('data: '.length);
      }
    }

    return SseEvent(event: event, data: data);
  }

  final String event;
  final String data;

  @override
  String toString() => 'SseEvent(event: $event, data: $data)';

  @override
  List<Object?> get props => [event, data];
}

import 'package:equatable/equatable.dart';

class SseEvent extends Equatable {
  const SseEvent({required this.event, required this.data, this.id});

  final String event;
  final String data;
  final List<String>? id;

  @override
  String toString() => 'SseEvent(id: $id, event: $event, data: $data)';

  @override
  List<Object?> get props => [event, data, id];
}

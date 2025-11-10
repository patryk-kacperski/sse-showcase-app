import 'package:equatable/equatable.dart';
import 'package:sse_showcase/features/examples/wikimedia/wikimedia_change_item.dart';

sealed class WikimediaState extends Equatable {
  const WikimediaState();

  @override
  List<Object?> get props => [];
}

class WikimediaInitial extends WikimediaState {
  const WikimediaInitial();
}

class WikimediaReceivingData extends WikimediaState {
  const WikimediaReceivingData({required this.events});

  final List<WikimediaChangeItem> events;

  @override
  List<Object?> get props => [events];
}

class WikimediaStopped extends WikimediaState {
  const WikimediaStopped({required this.events});

  final List<WikimediaChangeItem> events;

  @override
  List<Object?> get props => [events];
}

class WikimediaError extends WikimediaState {
  const WikimediaError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

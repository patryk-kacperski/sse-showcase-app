import 'package:equatable/equatable.dart';
import 'package:sse_showcase/models/api/number_data.dart';

sealed class StandardHttpExampleState extends Equatable {
  const StandardHttpExampleState();

  @override
  List<Object?> get props => [];
}

class StandardHttpExampleInitial extends StandardHttpExampleState {
  const StandardHttpExampleInitial();
}

class StandardHttpExampleLoading extends StandardHttpExampleState {
  const StandardHttpExampleLoading();
}

class StandardHttpExampleReceivingData extends StandardHttpExampleState {
  const StandardHttpExampleReceivingData({required this.numbers});

  final List<NumberData> numbers;

  @override
  List<Object?> get props => [numbers];
}

class StandardHttpExampleCompleted extends StandardHttpExampleState {
  const StandardHttpExampleCompleted({required this.numbers});

  final List<NumberData> numbers;

  @override
  List<Object?> get props => [numbers];
}

class StandardHttpExampleError extends StandardHttpExampleState {
  const StandardHttpExampleError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

import 'package:equatable/equatable.dart';

sealed class StandardHttpExampleState2 extends Equatable {
  const StandardHttpExampleState2();

  @override
  List<Object?> get props => [];
}

class StandardHttpExampleInitial extends StandardHttpExampleState2 {
  const StandardHttpExampleInitial();
}

class StandardHttpExampleLoading extends StandardHttpExampleState2 {
  const StandardHttpExampleLoading();
}

class StandardHttpExampleReceivingData extends StandardHttpExampleState2 {
  const StandardHttpExampleReceivingData({required this.numbers});

  final List<String> numbers;

  @override
  List<Object?> get props => [numbers];
}

class StandardHttpExampleCompleted extends StandardHttpExampleState2 {
  const StandardHttpExampleCompleted({required this.numbers});

  final List<String> numbers;

  @override
  List<Object?> get props => [numbers];
}

class StandardHttpExampleError extends StandardHttpExampleState2 {
  const StandardHttpExampleError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

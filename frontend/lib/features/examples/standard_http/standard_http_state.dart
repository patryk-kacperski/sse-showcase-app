import 'package:equatable/equatable.dart';
import 'package:sse_showcase/models/api/number_data.dart';

sealed class StandardHttpState extends Equatable {
  const StandardHttpState();

  @override
  List<Object?> get props => [];
}

class StandardHttpInitial extends StandardHttpState {
  const StandardHttpInitial();
}

class StandardHttpLoading extends StandardHttpState {
  const StandardHttpLoading();
}

class StandardHttpReceivingData extends StandardHttpState {
  final List<NumberData> numbers;

  const StandardHttpReceivingData({
    required this.numbers,
  });

  @override
  List<Object?> get props => [numbers];
}

class StandardHttpCompleted extends StandardHttpState {
  final List<NumberData> numbers;

  const StandardHttpCompleted({
    required this.numbers,
  });

  @override
  List<Object?> get props => [numbers];
}

class StandardHttpError extends StandardHttpState {
  final String message;

  const StandardHttpError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

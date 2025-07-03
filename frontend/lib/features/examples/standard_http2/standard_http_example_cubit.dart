import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sse_showcase/features/examples/standard_http2/standard_http_example_state.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';

class StandardHttpExampleCubit2 extends Cubit<StandardHttpExampleState2> {
  StandardHttpExampleCubit2({required SseService sseService})
    : _sseService = sseService,
      super(const StandardHttpExampleInitial());

  final SseService _sseService;

  Future<void> startStreaming() async {
    try {
      emit(const StandardHttpExampleLoading());

      final numbers = <String>[];

      await for (final sseEvent in _sseService.streamNumbers()) {
        numbers.add(sseEvent.data);
        emit(StandardHttpExampleReceivingData(numbers: List.from(numbers)));
      }

      emit(StandardHttpExampleCompleted(numbers: List.from(numbers)));
    } catch (error) {
      emit(StandardHttpExampleError(message: error.toString()));
    }
  }

  Future<void> refreshData() async {
    await startStreaming();
  }

  void clearData() {
    emit(const StandardHttpExampleInitial());
  }
}

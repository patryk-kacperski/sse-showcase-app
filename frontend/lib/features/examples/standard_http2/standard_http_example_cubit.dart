import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sse_showcase/features/examples/standard_http2/standard_http_example_state.dart';
import 'package:sse_showcase/models/api/sse_event.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';

class StandardHttpExampleCubit2 extends Cubit<StandardHttpExampleState2> {
  StandardHttpExampleCubit2({required SseService sseService})
    : _sseService = sseService,
      super(const StandardHttpExampleInitial());

  final SseService _sseService;
  StreamSubscription<SseEvent>? _streamSubscription;

  Future<void> startStreaming() async {
    _streamSubscription?.cancel();

    try {
      emit(const StandardHttpExampleLoading());

      final numbers = <String>[];

      _streamSubscription = _sseService.streamNumbers().listen(
        (sseEvent) {
          numbers.add(sseEvent.data);
          emit(StandardHttpExampleReceivingData(numbers: List.from(numbers)));
        },
        onError: (error) {
          emit(StandardHttpExampleError(message: error.toString()));
        },
        onDone: () {
          emit(StandardHttpExampleCompleted(numbers: List.from(numbers)));
        },
        cancelOnError: false,
      );
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

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

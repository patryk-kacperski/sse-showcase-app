import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sse_showcase/features/examples/standard_http/standard_http_example_state.dart';
import 'package:sse_showcase/models/api/number_data.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';

class StandardHttpExampleCubit extends Cubit<StandardHttpExampleState> {
  StandardHttpExampleCubit({required SseService sseService})
      : _sseService = sseService,
        super(const StandardHttpExampleInitial());

  final SseService _sseService;

  Future<void> startStreaming() async {
    try {
      emit(const StandardHttpExampleLoading());

      final numbers = <NumberData>[];

      await for (final numberData in _sseService.streamNumbers()) {
        numbers.add(numberData);
        emit(StandardHttpExampleReceivingData(numbers: List.from(numbers)));
      }

      emit(StandardHttpExampleCompleted(numbers: numbers));
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

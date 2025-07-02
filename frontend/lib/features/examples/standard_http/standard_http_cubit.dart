import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sse_showcase/features/examples/standard_http/standard_http_state.dart';
import 'package:sse_showcase/models/api/number_data.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';

class StandardHttpCubit extends Cubit<StandardHttpState> {
  StandardHttpCubit({required SseService sseService})
    : _sseService = sseService,
      super(const StandardHttpInitial());

  final SseService _sseService;

  Future<void> startStreaming() async {
    try {
      emit(const StandardHttpLoading());

      final numbers = <NumberData>[];

      await for (final numberData in _sseService.streamNumbers()) {
        numbers.add(numberData);
        emit(StandardHttpReceivingData(numbers: List.from(numbers)));
      }

      emit(StandardHttpCompleted(numbers: numbers));
    } catch (error) {
      emit(StandardHttpError(message: error.toString()));
    }
  }

  Future<void> refreshData() async {
    await startStreaming();
  }

  void clearData() {
    emit(const StandardHttpInitial());
  }
}

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:sse_showcase/features/examples/standard_http/standard_http_example_state.dart';
import 'package:sse_showcase/utils/api.dart';

class StandardHttpExampleCubit extends Cubit<StandardHttpExampleState> {
  StandardHttpExampleCubit({required Client client})
    : _client = client,
      super(const StandardHttpExampleInitial());

  final Client _client;

  Future<void> startStreaming() async {
    try {
      emit(const StandardHttpExampleLoading());

      final numbers = <String>[];

      final request = createNumbersRequest();

      final response = await _client.send(request);

      if (response.statusCode != 200) {
        emit(
          StandardHttpExampleError(
            message: 'Failed to connect: ${response.statusCode}',
          ),
        );
        return;
      }

      await for (final chunk in response.stream.transform(utf8.decoder)) {
        numbers.add(chunk);
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

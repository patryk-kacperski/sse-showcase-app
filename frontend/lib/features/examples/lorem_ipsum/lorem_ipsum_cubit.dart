import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sse_showcase/features/examples/lorem_ipsum/lorem_ipsum_state.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';

class LoremIpsumCubit extends Cubit<LoremIpsumState> {
  LoremIpsumCubit({required SseService sseService})
    : _sseService = sseService,
      super(const LoremIpsumInitial());

  final SseService _sseService;

  Future<void> startStreaming() async {
    try {
      emit(const LoremIpsumLoading());

      final textBuffer = StringBuffer();

      await for (final sseEvent in _sseService.streamLoremIpsum()) {
        final jsonData = jsonDecode(sseEvent.data) as Map<String, dynamic>;

        final chunk = jsonData['chunk'] as String;
        final charactersSent = jsonData['characters_sent'] as int;
        final charactersRemaining = jsonData['characters_remaining'] as int;

        textBuffer.write(chunk);

        emit(
          LoremIpsumReceivingData(
            text: textBuffer.toString(),
            charactersSent: charactersSent,
            charactersRemaining: charactersRemaining,
          ),
        );
      }

      if (state is LoremIpsumReceivingData) {
        final currentState = state as LoremIpsumReceivingData;
        emit(
          LoremIpsumCompleted(
            text: currentState.text,
            charactersSent: currentState.charactersSent,
          ),
        );
      }
    } catch (error) {
      emit(LoremIpsumError(message: error.toString()));
    }
  }

  Future<void> refreshData() async {
    await startStreaming();
  }

  void clearData() {
    emit(const LoremIpsumInitial());
  }
}

// TODO: Git connection
// TODO: JSON Serialization
// TODO: Handle error after leaving the screen while streaming

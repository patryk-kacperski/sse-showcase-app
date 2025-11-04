import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sse_showcase/features/examples/lorem_ipsum/lorem_ipsum_state.dart';
import 'package:sse_showcase/models/api/lorem_ipsum_chunk.dart';
import 'package:sse_showcase/models/api/sse_event.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';

class LoremIpsumCubit extends Cubit<LoremIpsumState> {
  LoremIpsumCubit({required SseService sseService})
    : _sseService = sseService,
      super(const LoremIpsumInitial());

  final SseService _sseService;
  StreamSubscription<SseEvent>? _streamSubscription;

  Future<void> startStreaming() async {
    _streamSubscription?.cancel();

    try {
      emit(const LoremIpsumLoading());

      final textBuffer = StringBuffer();

      _streamSubscription = _sseService.streamLoremIpsum().listen(
        (sseEvent) {
          final jsonData = jsonDecode(sseEvent.data) as Map<String, dynamic>;
          final loremIpsumChunk = LoremIpsumChunk.fromJson(jsonData);

          textBuffer.write(loremIpsumChunk.chunk);

          emit(
            LoremIpsumReceivingData(
              text: textBuffer.toString(),
              charactersSent: loremIpsumChunk.charactersSent,
              charactersRemaining: loremIpsumChunk.charactersRemaining,
            ),
          );
        },
        onError: (error) {
          emit(LoremIpsumError(message: error.toString()));
        },
        onDone: () {
          if (state is LoremIpsumReceivingData) {
            final currentState = state as LoremIpsumReceivingData;
            emit(
              LoremIpsumCompleted(
                text: currentState.text,
                charactersSent: currentState.charactersSent,
              ),
            );
          }
        },
        cancelOnError: false,
      );
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

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

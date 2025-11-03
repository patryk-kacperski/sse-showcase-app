import 'package:equatable/equatable.dart';

sealed class LoremIpsumState extends Equatable {
  const LoremIpsumState();

  @override
  List<Object?> get props => [];
}

class LoremIpsumInitial extends LoremIpsumState {
  const LoremIpsumInitial();
}

class LoremIpsumLoading extends LoremIpsumState {
  const LoremIpsumLoading();
}

class LoremIpsumReceivingData extends LoremIpsumState {
  const LoremIpsumReceivingData({
    required this.text,
    required this.charactersSent,
    required this.charactersRemaining,
  });

  final String text;
  final int charactersSent;
  final int charactersRemaining;

  @override
  List<Object?> get props => [text, charactersSent, charactersRemaining];
}

class LoremIpsumCompleted extends LoremIpsumState {
  const LoremIpsumCompleted({required this.text, required this.charactersSent});

  final String text;
  final int charactersSent;

  @override
  List<Object?> get props => [text, charactersSent];
}

class LoremIpsumError extends LoremIpsumState {
  const LoremIpsumError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lorem_ipsum_chunk.g.dart';

@JsonSerializable()
class LoremIpsumChunk extends Equatable {
  const LoremIpsumChunk({
    required this.chunk,
    required this.charactersSent,
    required this.charactersRemaining,
  });

  factory LoremIpsumChunk.fromJson(Map<String, dynamic> json) =>
      _$LoremIpsumChunkFromJson(json);

  Map<String, dynamic> toJson() => _$LoremIpsumChunkToJson(this);

  final String chunk;

  @JsonKey(name: 'characters_sent')
  final int charactersSent;

  @JsonKey(name: 'characters_remaining')
  final int charactersRemaining;

  @override
  List<Object?> get props => [chunk, charactersSent, charactersRemaining];
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lorem_ipsum_chunk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoremIpsumChunk _$LoremIpsumChunkFromJson(Map<String, dynamic> json) =>
    LoremIpsumChunk(
      chunk: json['chunk'] as String,
      charactersSent: (json['characters_sent'] as num).toInt(),
      charactersRemaining: (json['characters_remaining'] as num).toInt(),
    );

Map<String, dynamic> _$LoremIpsumChunkToJson(LoremIpsumChunk instance) =>
    <String, dynamic>{
      'chunk': instance.chunk,
      'characters_sent': instance.charactersSent,
      'characters_remaining': instance.charactersRemaining,
    };

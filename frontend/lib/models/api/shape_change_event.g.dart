// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shape_change_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShapeChangeEvent _$ShapeChangeEventFromJson(Map<String, dynamic> json) =>
    ShapeChangeEvent(
      shape: json['shape'] as String,
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$ShapeChangeEventToJson(ShapeChangeEvent instance) =>
    <String, dynamic>{'shape': instance.shape, 'size': instance.size};

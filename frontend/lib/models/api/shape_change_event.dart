import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shape_change_event.g.dart';

@JsonSerializable()
class ShapeChangeEvent extends Equatable {
  const ShapeChangeEvent({required this.shape, required this.size});

  factory ShapeChangeEvent.fromJson(Map<String, dynamic> json) =>
      _$ShapeChangeEventFromJson(json);

  Map<String, dynamic> toJson() => _$ShapeChangeEventToJson(this);

  final String shape;
  final int size;

  @override
  List<Object?> get props => [shape, size];
}

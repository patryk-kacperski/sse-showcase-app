import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'color_change_event.g.dart';

@JsonSerializable()
class ColorChangeEvent extends Equatable {
  const ColorChangeEvent({required this.color, required this.intensity});

  factory ColorChangeEvent.fromJson(Map<String, dynamic> json) =>
      _$ColorChangeEventFromJson(json);

  Map<String, dynamic> toJson() => _$ColorChangeEventToJson(this);

  final String color;
  final String intensity;

  @override
  List<Object?> get props => [color, intensity];
}

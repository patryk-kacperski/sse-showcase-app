import 'package:equatable/equatable.dart';

class NumberData extends Equatable {
  const NumberData({required this.value});

  factory NumberData.fromString(String data) {
    return NumberData(value: int.parse(data));
  }

  final int value;

  @override
  String toString() => 'NumberData(value: $value)';

  @override
  List<Object?> get props => [value];
}

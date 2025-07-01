import 'package:equatable/equatable.dart';

class NumberData extends Equatable {
  final int value;

  const NumberData({
    required this.value,
  });

  factory NumberData.fromString(String data) {
    return NumberData(value: int.parse(data));
  }

  @override
  String toString() => 'NumberData(value: $value)';

  @override
  List<Object?> get props => [value];
}

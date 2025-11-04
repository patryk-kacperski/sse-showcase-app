import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class ShapesAndColorsState extends Equatable {
  const ShapesAndColorsState();

  ShapesAndColorsState copyWith({
    String? shape,
    int? size,
    Color? color,
    String? intensity,
  });

  @override
  List<Object?> get props => [];
}

class ShapesAndColorsInitial extends ShapesAndColorsState {
  const ShapesAndColorsInitial();

  @override
  ShapesAndColorsState copyWith({
    String? shape,
    int? size,
    Color? color,
    String? intensity,
  }) {
    return const ShapesAndColorsInitial();
  }
}

class ShapesAndColorsLoading extends ShapesAndColorsState {
  const ShapesAndColorsLoading();

  @override
  ShapesAndColorsState copyWith({
    String? shape,
    int? size,
    Color? color,
    String? intensity,
  }) {
    return const ShapesAndColorsLoading();
  }
}

class ShapesAndColorsReceivingData extends ShapesAndColorsState {
  const ShapesAndColorsReceivingData({
    required this.shape,
    required this.size,
    required this.color,
    required this.intensity,
  });

  final String shape;
  final int size;
  final Color color;
  final String intensity;

  @override
  ShapesAndColorsReceivingData copyWith({
    String? shape,
    int? size,
    Color? color,
    String? intensity,
  }) {
    return ShapesAndColorsReceivingData(
      shape: shape ?? this.shape,
      size: size ?? this.size,
      color: color ?? this.color,
      intensity: intensity ?? this.intensity,
    );
  }

  @override
  List<Object?> get props => [shape, size, color, intensity];
}

class ShapesAndColorsError extends ShapesAndColorsState {
  const ShapesAndColorsError({required this.message});

  final String message;

  @override
  ShapesAndColorsState copyWith({
    String? shape,
    int? size,
    Color? color,
    String? intensity,
  }) {
    return ShapesAndColorsError(message: message);
  }

  @override
  List<Object?> get props => [message];
}

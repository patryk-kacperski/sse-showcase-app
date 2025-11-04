import 'package:flutter/material.dart';

class ColorUtils {
  static Color getColor(String color, String intensity) {
    switch (color.toLowerCase()) {
      case 'red':
        switch (intensity.toLowerCase()) {
          case 'low':
            return const Color(0xFFFFB3B3);
          case 'medium':
            return const Color(0xFFFF6666);
          case 'high':
            return const Color(0xFFCC0000);
          default:
            return const Color(0xFFFF6666);
        }
      case 'green':
        switch (intensity.toLowerCase()) {
          case 'low':
            return const Color(0xFFB3FFB3);
          case 'medium':
            return const Color(0xFF66FF66);
          case 'high':
            return const Color(0xFF00CC00);
          default:
            return const Color(0xFF66FF66);
        }
      case 'blue':
        switch (intensity.toLowerCase()) {
          case 'low':
            return const Color(0xFFB3B3FF);
          case 'medium':
            return const Color(0xFF6666FF);
          case 'high':
            return const Color(0xFF0000CC);
          default:
            return const Color(0xFF6666FF);
        }
      case 'yellow':
        switch (intensity.toLowerCase()) {
          case 'low':
            return const Color(0xFFFFFFB3);
          case 'medium':
            return const Color(0xFFFFFF66);
          case 'high':
            return const Color(0xFFCCCC00);
          default:
            return const Color(0xFFFFFF66);
        }
      default:
        return const Color(0xFFFF6666);
    }
  }
}

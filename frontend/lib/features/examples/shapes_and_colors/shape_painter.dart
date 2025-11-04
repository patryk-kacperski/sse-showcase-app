import 'dart:math' as math;
import 'package:flutter/material.dart';

class ShapePainter extends CustomPainter {
  const ShapePainter({
    required this.shape,
    required this.size,
    required this.color,
  });

  final String shape;
  final double size;
  final Color color;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(canvasSize.width / 2, canvasSize.height / 2);

    switch (shape.toLowerCase()) {
      case 'circle':
        canvas.drawCircle(center, size / 2, paint);
        break;
      case 'triangle':
        _drawTriangle(canvas, center, size, paint);
        break;
      case 'square':
        _drawSquare(canvas, center, size, paint);
        break;
      case 'hexagon':
        _drawHexagon(canvas, center, size, paint);
        break;
    }
  }

  void _drawTriangle(Canvas canvas, Offset center, double height, Paint paint) {
    final sideLength = (2 * height) / math.sqrt(3);
    final halfSide = sideLength / 2;
    final verticalOffset = height / 3;

    final path = Path()
      ..moveTo(center.dx, center.dy - height + verticalOffset)
      ..lineTo(center.dx - halfSide, center.dy + verticalOffset)
      ..lineTo(center.dx + halfSide, center.dy + verticalOffset)
      ..close();

    canvas.drawPath(path, paint);
  }

  void _drawSquare(Canvas canvas, Offset center, double side, Paint paint) {
    final rect = Rect.fromCenter(center: center, width: side, height: side);
    canvas.drawRect(rect, paint);
  }

  void _drawHexagon(
    Canvas canvas,
    Offset center,
    double longestDiagonal,
    Paint paint,
  ) {
    final radius = longestDiagonal / 2;
    final path = Path();

    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ShapePainter oldDelegate) {
    return oldDelegate.shape != shape ||
        oldDelegate.size != size ||
        oldDelegate.color != color;
  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

class HexagonLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.5;

    // Outer hexagon
    final outerHexagonPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    _drawHexagon(canvas, center, radius, outerHexagonPaint);

    // Middle dashed hexagon
    final dashedHexagonPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    _drawDashedHexagon(canvas, center, radius * 0.75, dashedHexagonPaint);

    // Inner circle
    final circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, radius * 0.45, circlePaint);
  }

  void _drawHexagon(Canvas canvas, Offset center, double radius, Paint paint) {
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

  void _drawDashedHexagon(Canvas canvas, Offset center, double radius, Paint paint) {
    for (int i = 0; i < 6; i++) {
      final angle1 = (math.pi / 3) * i - math.pi / 2;
      final angle2 = (math.pi / 3) * (i + 1) - math.pi / 2;
      
      final x1 = center.dx + radius * math.cos(angle1);
      final y1 = center.dy + radius * math.sin(angle1);
      final x2 = center.dx + radius * math.cos(angle2);
      final y2 = center.dy + radius * math.sin(angle2);
      
      _drawDashedLine(canvas, Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 4.0;
    const dashSpace = 3.0;
    
    final path = Path();
    final distance = (end - start).distance;
    final unitVector = (end - start) / distance;
    
    double currentDistance = 0;
    bool isDash = true;
    
    while (currentDistance < distance) {
      final segmentLength = isDash ? dashWidth : dashSpace;
      final nextDistance = (currentDistance + segmentLength).clamp(0.0, distance);
      
      if (isDash) {
        final segmentStart = start + unitVector * currentDistance;
        final segmentEnd = start + unitVector * nextDistance;
        canvas.drawLine(segmentStart, segmentEnd, paint);
      }
      
      currentDistance = nextDistance;
      isDash = !isDash;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
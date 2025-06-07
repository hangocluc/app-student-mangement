import 'package:flutter/material.dart';

class SmallCirclePainter extends CustomPainter {
  final double radius;
  final Color borderColor;
  final double borderWidth;

  SmallCirclePainter({
    required this.radius,
    this.borderColor = Colors.black,
    this.borderWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

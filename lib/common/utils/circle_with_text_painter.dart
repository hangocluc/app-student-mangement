import 'package:flutter/material.dart';

import '../theme/app_color.dart';
import '../theme/app_typography.dart';

class CircleWithTextPainter extends CustomPainter {
  final double size;
  final Color color;
  final String text;
  final Color? textColor;

  CircleWithTextPainter(
      {required this.size,
      required this.color,
      required this.text,
      this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double radius = this.size / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, circlePaint);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: AppTypography()
            .bodyLargeSemiBold
            .copyWith(color: textColor ?? AppColors.white.white),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final Offset textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

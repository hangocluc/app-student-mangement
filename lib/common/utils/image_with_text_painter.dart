import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../theme/app_color.dart';
import '../theme/app_typography.dart';

class ImageWithTextPainter extends CustomPainter {
  final String text;
  final bool? networkImage;
  final ui.Image img;

  ImageWithTextPainter(
      {required this.text, this.networkImage, required this.img});

  @override
  void paint(Canvas canvas, Size size) async {
    canvas.drawImage(img, const Offset(0, 0), Paint());

    final textStyle =
        AppTypography().bodyXSmallMedium.copyWith(color: AppColors.white.white);
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

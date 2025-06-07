import 'package:flutter/cupertino.dart';

class CustomPathBuilder {
  static Path buildCustomTail(
      Offset tip, Offset point2, Offset point3, BuildContext context) {
    return Path()
      ..moveTo(tip.dx, tip.dy - 6)
      ..lineTo(point2.dx + 5, point2.dy)
      ..lineTo(point3.dx - 5, point3.dy)
      ..close();
  }

  static Path buildCustomRectangleWithRoundedCorners(
      Offset topLeft, double width, double height, double radius) {
    final path = Path();

    path.moveTo(topLeft.dx, topLeft.dy);

    path.lineTo(topLeft.dx + width - radius, topLeft.dy);

    path.quadraticBezierTo(
      topLeft.dx + width,
      topLeft.dy,
      topLeft.dx + width,
      topLeft.dy + radius,
    );

    path.lineTo(topLeft.dx + width, topLeft.dy + height - radius);

    path.quadraticBezierTo(
      topLeft.dx + width,
      topLeft.dy + height,
      topLeft.dx + width - radius,
      topLeft.dy + height,
    );

    path.lineTo(topLeft.dx + radius, topLeft.dy + height);

    path.quadraticBezierTo(
      topLeft.dx,
      topLeft.dy + height,
      topLeft.dx,
      topLeft.dy + height - radius,
    );

    path.lineTo(topLeft.dx, topLeft.dy);

    path.close();

    return path;
  }
}

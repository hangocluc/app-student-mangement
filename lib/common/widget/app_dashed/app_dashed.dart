import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color.dart';

class AppDashed extends StatelessWidget {
  const AppDashed({
    super.key,
    this.height,
    this.color,
  });

  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height ?? 1.5.h;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();

        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color ?? AppColors.primary.primary400,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

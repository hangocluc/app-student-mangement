import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';
import '../../theme/app_color.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../app_icon/app_asset_image.dart';

class AppWidgetTitle extends StatelessWidget {
  final String? title;
  final TextStyle? styleTitle;
  final double? widthIcon;
  final double? height;
  final String? pathIcon;
  final bool isRight;
  final Color? icColor;

  const AppWidgetTitle(
      {super.key,
      this.title,
      this.styleTitle,
      this.widthIcon,
      this.height,
      this.icColor,
      this.pathIcon,
      this.isRight = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: !isRight,
          child: AppAssetImage(
            path: pathIcon ?? appIcon.icChevronLeft.path,
            width: widthIcon ?? 16.w,
            height: height ?? 16.h,
            color: icColor,
          ),
        ),
        Text(
          title ?? '',
          style: styleTitle ??
              AppTypography().bodyXSmallSemiBold.copyWith(
                    color: AppColors.white.white,
                  ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          width: AppSpacing.spacing3,
        ),
        Visibility(
          visible: isRight,
          child: AppAssetImage(
            path: pathIcon ?? appIcon.icChevronRight.path,
            width: widthIcon ?? 16.w,
            height: height ?? 16.h,
            color: icColor ?? AppColors.white.white,
          ),
        ),
      ],
    );
  }
}

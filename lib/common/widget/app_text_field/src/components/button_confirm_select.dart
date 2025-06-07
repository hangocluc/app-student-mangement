import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../main.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/app_effect.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../../app_icon/app_asset_image.dart';

class ButtonConfirmSelect extends StatefulWidget {
  final Function onTap;
  final Color? buttonColor;
  final Color? borderColor;
  final String title;
  final String? subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final double? height;
  final double? width;
  final double? radius;
  final List<BoxShadow>? boxShadows;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const ButtonConfirmSelect({
    super.key,
    required this.onTap,
    this.buttonColor,
    this.borderColor,
    required this.title,
    this.subTitle,
    this.titleStyle,
    this.height,
    this.width,
    this.subTitleStyle,
    this.radius,
    this.boxShadows,
    this.padding,
    this.margin,
  });

  @override
  State<ButtonConfirmSelect> createState() => _ButtonConfirmSelectState();
}

class _ButtonConfirmSelectState extends State<ButtonConfirmSelect> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            widget.onTap();
          },
          child: Container(
            height: widget.height,
            alignment: Alignment.center,
            width: widget.width,
            padding: widget.padding ??
                const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing4,
                    vertical: AppSpacing.spacing4),
            margin: widget.margin ??
                const EdgeInsets.symmetric(horizontal: AppSpacing.spacing4),
            decoration: BoxDecoration(
                color: widget.buttonColor ?? AppColors.primary.primary400,
                borderRadius:
                    BorderRadius.circular(widget.radius ?? widget.height ?? 12),
                border: Border.all(
                  width: 1,
                  color: widget.borderColor ??
                      widget.buttonColor ??
                      AppColors.primary.primary400,
                ),
                boxShadow: widget.boxShadows ??
                    [
                      AppEffect.shadow.boxM,
                    ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: widget.titleStyle ??
                      AppTypography()
                          .bodyMediumSemiBold
                          .copyWith(color: AppColors.white.white),
                  textAlign: TextAlign.center,
                ),
                AppAssetImage(
                  path: appIcon.icCheck.path,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: AppSpacing.spacing5,
        ),
        Container(
          width: 148.w,
          height: 5.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppColors.other.ColorCBD5E1,
          ),
        ),
        const SizedBox(
          height: AppSpacing.spacing2,
        ),
      ],
    );
  }
}

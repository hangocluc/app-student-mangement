import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';
import '../../theme/app_color.dart';
import '../../theme/app_effect.dart';
import '../app_icon/app_asset_image.dart';

class AppButtonWidthRightIcon extends StatefulWidget {
  final Function onTap;
  final Color? buttonColor;
  final Color? borderColor;
  final String? title;
  final TextStyle? titleStyle;
  final double? height;
  final double? width;
  final double? radius;
  final List<BoxShadow>? boxShadows;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? titleWidget;
  final String? iconPath;

  const AppButtonWidthRightIcon({
    super.key,
    required this.onTap,
    this.buttonColor,
    this.borderColor,
    this.title,
    this.titleStyle,
    this.height,
    this.width,
    this.radius,
    this.boxShadows,
    this.padding,
    this.margin,
    this.titleWidget,
    this.iconPath,
  });

  @override
  State<AppButtonWidthRightIcon> createState() =>
      _AppButtonWidthRightIconState();
}

class _AppButtonWidthRightIconState extends State<AppButtonWidthRightIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: widget.height,
        alignment: Alignment.center,
        width: widget.width,
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
            color: widget.buttonColor ?? AppColors.primary.primary500,
            borderRadius:
                BorderRadius.circular(widget.radius ?? widget.height ?? 100),
            border: Border.all(
              width: 1,
              color: widget.borderColor ??
                  widget.buttonColor ??
                  AppColors.primary.primary500,
            ),
            boxShadow: widget.boxShadows ??
                [
                  AppEffect.shadow.boxM,
                ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.titleWidget ??
                Text(
                  widget.title ?? '',
                  style: widget.titleStyle,
                  textAlign: TextAlign.center,
                ),
            SizedBox.square(
              dimension: 24.w,
              child: AppAssetImage(
                path: widget.iconPath ?? appIcon.icCheckWhite.path,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

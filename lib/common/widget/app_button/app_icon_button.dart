import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
import '../../theme/app_effect.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../app_icon/app_asset_image.dart';
import '../app_text/app_text.dart';

class AppIconButton extends StatefulWidget {
  final Function onTap;
  final Color? buttonColor;
  final Color? borderColor;
  final String title;
  final String iconPath;
  final String? subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final double? height;
  final double? width;
  final double? radius;
  final List<BoxShadow>? boxShadows;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const AppIconButton({
    super.key,
    required this.onTap,
    this.buttonColor,
    this.borderColor,
    required this.title,
    required this.iconPath,
    this.subTitle,
    this.titleStyle,
    this.subTitleStyle,
    this.height,
    this.width,
    this.radius,
    this.boxShadows,
    this.padding,
    this.margin,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
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
          borderRadius: BorderRadius.circular(
            widget.radius ?? AppRadius.radiusMax.x,
          ),
          border: Border.all(
            width: 1,
            color: widget.borderColor ??
                widget.buttonColor ??
                AppColors.primary.primary500,
          ),
          boxShadow: widget.boxShadows ?? [AppEffect.shadow.boxM],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            AppText(
              title: widget.title,
              style: widget.titleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: AppSpacing.spacing3),
            AppAssetImage.icon24(path: widget.iconPath),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
import '../../theme/app_effect.dart';

class AppButton extends StatefulWidget {
  final Function onTap;
  final Color? buttonColor;
  final Color? borderColor;
  final String? title;
  final String? subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final double? height;
  final double? width;
  final double? radius;
  final List<BoxShadow>? boxShadows;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? titleWidget;

  const AppButton({
    super.key,
    required this.onTap,
    this.buttonColor,
    this.borderColor,
    this.title,
    this.subTitle,
    this.titleStyle,
    this.height,
    this.width,
    this.subTitleStyle,
    this.radius,
    this.boxShadows,
    this.padding,
    this.margin,
    this.titleWidget,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            widget.titleWidget ??
                Text(
                  widget.title ?? '',
                  overflow: TextOverflow.fade,
                  style: widget.titleStyle,
                  textAlign: TextAlign.center,
                ),
            // ...widget.subTitle.isNotNullOrEmpty
            //     ? [
            //         Text(
            //           widget.subTitle ?? '',
            //           style: widget.subTitleStyle,
            //         )
            //       ]
            //     : [],
          ],
        ),
      ),
    );
  }
}

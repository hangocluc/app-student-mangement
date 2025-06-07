import 'package:flutter/material.dart';

import '../../theme/app_typography.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.title,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  final String title;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ?? AppTypography().bodyXSmallRegular,
      strutStyle: strutStyle,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow ?? TextOverflow.ellipsis,
      textScaler: textScaler,
      maxLines: maxLines ?? 1,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}

import 'package:flutter/material.dart';

const String NotoSansJP = "NotoSansJP";
const Color bodyTextColor = Color(0xFF667085);
const Color headingColor = Color(0xFF121A26);

class AppTypography {
  TextStyle get bodyXSmallSemiBold => _BodyXSmall.SemiBold;

  TextStyle get bodyXSmallRegular => _BodyXSmall.Regular;

  TextStyle get bodyXSmallMedium => _BodyXSmall.Medium;

  TextStyle get bodySmallSemiBold => _BodySmall.SemiBold;

  TextStyle get bodySmallRegular => _BodySmall.Regular;

  TextStyle get bodySmallMedium => _BodySmall.Medium;

  TextStyle get bodyMediumSemiBold => _BodyMedium.SemiBold;

  TextStyle get bodyMediumRegular => _BodyMedium.Regular;

  TextStyle get bodyMediumMedium => _BodyMedium.Medium;

  TextStyle get bodyLargeSemiBold => _BodyLarge.SemiBold;

  TextStyle get bodyLargeRegular => _BodyLarge.Regular;

  TextStyle get bodyLargeMedium => _BodyLarge.Medium;

  TextStyle get heading1 => _Heading.Heading1;

  TextStyle get heading2 => _Heading.Heading2;

  TextStyle get heading3 => _Heading.Heading3;

  TextStyle get heading4 => _Heading.Heading4;

  TextStyle get heading5 => _Heading.Heading5;

  TextStyle get heading6 => _Heading.Heading6;

  TextStyle get heading7 => _Heading.Heading7;
}

class _BodyXSmall {
  static const SemiBold = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 12,
      color: bodyTextColor,
      fontWeight: FontWeight.w700,
      height: 16 / 12);
  static const Regular = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 12,
      color: bodyTextColor,
      fontWeight: FontWeight.w400,
      height: 16 / 12);

  static const Medium = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 12,
      color: bodyTextColor,
      fontWeight: FontWeight.w500,
      height: 16 / 12);
}

class _BodySmall {
  static const SemiBold = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 14,
      color: bodyTextColor,
      fontWeight: FontWeight.w700,
      height: 21.7 / 14);
  static const Regular = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 14,
      color: bodyTextColor,
      fontWeight: FontWeight.w400,
      height: 21.7 / 14);
  static const Medium = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 14,
      color: bodyTextColor,
      fontWeight: FontWeight.w500,
      height: 21.7 / 14);
}

class _BodyMedium {
  static const SemiBold = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 16,
      color: bodyTextColor,
      fontWeight: FontWeight.w700,
      height: 24.8 / 16);
  static const Regular = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 16,
      color: bodyTextColor,
      fontWeight: FontWeight.w400,
      height: 24.8 / 16);
  static const Medium = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 16,
      color: bodyTextColor,
      fontWeight: FontWeight.w500,
      height: 24.8 / 16);
}

class _BodyLarge {
  static const SemiBold = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 18,
      color: bodyTextColor,
      fontWeight: FontWeight.w700,
      height: 27.9 / 18);
  static const Regular = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 18,
      color: bodyTextColor,
      fontWeight: FontWeight.w400,
      height: 27.9 / 18);
  static const Medium = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 18,
      color: bodyTextColor,
      fontWeight: FontWeight.w500,
      height: 27.9 / 18);
}

class _Heading {
  static const Heading1 = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 48,
      fontWeight: FontWeight.w700,
      height: 57.6 / 48,
      color: headingColor);
  static const Heading2 = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 40,
      fontWeight: FontWeight.w700,
      height: 48 / 40,
      color: headingColor);
  static const Heading3 = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 44.8 / 32,
      color: headingColor);
  static const Heading4 = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 36 / 24,
      color: headingColor);
  static const Heading5 = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 28 / 20,
      color: headingColor);
  static const Heading6 = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 25.2 / 18,
      color: headingColor);
  static const Heading7 = TextStyle(
      fontFamily: NotoSansJP,
      fontSize: 18,
      fontWeight: FontWeight.w900,
      height: 25.2 / 18,
      color: headingColor);
}

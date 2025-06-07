import 'package:flutter/material.dart';

class AppOnlyTextParam {
  final String appBarTitle;
  final String? title;
  final String? content;
  final String? notice;
  final TextStyle? contentStyle;
  final VoidCallback? onSubmit;
  final Widget? child;
  final String? submitTitle;

  AppOnlyTextParam({
    required this.appBarTitle,
    this.title,
    this.content,
    this.notice,
    this.contentStyle,
    this.onSubmit,
    this.child,
    this.submitTitle,
  });
}

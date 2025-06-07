import 'dart:ui';

import 'package:flutter/material.dart';

sealed class DemoState {}

class DemoStateInitial extends DemoState {}

class DemoStateLoading extends DemoState {}

class DemoStateFailure extends DemoState {
  final String message;

  DemoStateFailure({required this.message});
}

class DemoStateSuccess extends DemoState {
  final dynamic data;

  DemoStateSuccess({this.data});
}

class LanguageStateSuccess extends DemoState {
  final Locale locale;

  LanguageStateSuccess({required this.locale});
}

class ThemeStateSuccess extends DemoState {
  final ThemeMode themeMode;

  ThemeStateSuccess({required this.themeMode});
}

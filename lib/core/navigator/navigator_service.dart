import 'package:flutter/material.dart';

class NavigationService {
  String? currentPath = '';

  final navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> navigatorKeyChat = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> navigatorKeyNotify = GlobalKey<NavigatorState>();

  final navigatorKeySetting = GlobalKey<NavigatorState>();

  BuildContext? get navigatorContext => navigatorKey.currentState?.context;
  NavigatorState? get navigatorState => navigatorKey.currentState;

  void handleNoInternet() {
    if (currentPath != '/error') {
      Navigator.of(navigatorContext!).pushNamed('/error');
    }
  }
}

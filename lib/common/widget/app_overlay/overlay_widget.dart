import 'dart:async';

import 'package:flutter/material.dart';

import 'app_overlay.dart';
import 'app_overlay_container.dart';
import 'app_overlay_entry.dart';
import 'app_overlay_status.dart';

class OverlayWidget {
  factory OverlayWidget() => _instance;
  static final OverlayWidget _instance = OverlayWidget._internal();

  static OverlayWidget get instance => _instance;

  static bool get isShow => _instance.widget != null;
  final List<OverlayStatusCallback> _statusCallbacks =
      <OverlayStatusCallback>[];
  Widget? widget;
  AppOverlayEntry? overlayEntry;
  GlobalKey<AppOverlayContainerState>? _key;

  OverlayWidget._internal();

  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, AppOverlay(child: child));
      } else {
        return AppOverlay(child: child);
      }
    };
  }

  static Future<void> show({
    required Widget widgetIn,
    bool? dismissOnTap,
  }) {
    Widget w = widgetIn;
    return _instance._show(
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  static Future<void> dismiss({
    bool animation = true,
  }) {
    return _instance._dismiss(animation);
  }

  Future<void> _show({
    required Widget w,
    bool? dismissOnTap,
  }) async {
    Completer<void> completer = Completer<void>();
    _key = GlobalKey<AppOverlayContainerState>();
    widget = AppOverlayContainer(
      key: _key,
      completer: completer,
      child: w,
    );
    completer.future.whenComplete(() {
      // callback handler
    });
    _markNeedsBuild();
    return completer.future;
  }

  Future<void> _dismiss(bool animation) async {
    if (_key != null && _key?.currentState == null) {
      _reset();
      return;
    }
    if (animation) {
      return _key?.currentState?.dismiss(animation).whenComplete(() {
        _reset();
      });
    } else {
      _reset();
    }
  }

  void _reset() {
    widget = null;
    _key = null;

    _markNeedsBuild();
    _callback(OverlayStatus.dismiss);
  }

  void _callback(OverlayStatus status) {
    for (final OverlayStatusCallback callback in _statusCallbacks) {
      callback(status);
    }
  }

  void _markNeedsBuild() {
    overlayEntry?.markNeedsBuild();
  }
}

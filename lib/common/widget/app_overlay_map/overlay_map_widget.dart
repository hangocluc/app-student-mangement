import 'dart:async';

import 'package:flutter/material.dart';

import 'app_overlay_map.dart';
import 'app_overlay_map_container.dart';
import 'app_overlay_map_entry.dart';
import 'app_overlay_map_status.dart';

class OverlayMapWidget {
  factory OverlayMapWidget() => _instance;
  static final OverlayMapWidget _instance = OverlayMapWidget._internal();

  static OverlayMapWidget get instance => _instance;

  static bool get isShow => _instance.widget != null;
  final List<OverlayMapStatusCallback> _statusCallbacks =
      <OverlayMapStatusCallback>[];
  Widget? widget;
  AppOverlayMapEntry? overlayMapEntry;
  GlobalKey<AppOverlayMapContainerState>? _key;

  OverlayMapWidget._internal();

  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, AppOverlayMap(child: child));
      } else {
        return AppOverlayMap(child: child);
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
    _key = GlobalKey<AppOverlayMapContainerState>();
    widget = AppOverlayMapContainer(
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
    _callback(OverlayMapStatus.dismiss);
  }

  void _callback(OverlayMapStatus status) {
    for (final OverlayMapStatusCallback callback in _statusCallbacks) {
      callback(status);
    }
  }

  void _markNeedsBuild() {
    overlayMapEntry?.markNeedsBuild();
  }
}

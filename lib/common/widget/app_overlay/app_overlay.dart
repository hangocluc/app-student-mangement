import 'package:flutter/material.dart';

import 'app_overlay_entry.dart';
import 'overlay_widget.dart';

class AppOverlay extends StatefulWidget {
  final Widget? child;

  const AppOverlay({
    super.key,
    required this.child,
  }) : assert(child != null);

  @override
  _AppOverlayState createState() => _AppOverlayState();
}

class _AppOverlayState extends State<AppOverlay> {
  late AppOverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = AppOverlayEntry(
      builder: (BuildContext context) => Positioned(
        bottom: 0, // Position at the bottom
        right: 0, // Position at the right
        child: OverlayWidget.instance.widget ?? Container(),
      ),
    );
    OverlayWidget.instance.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          AppOverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
          _overlayEntry,
        ],
      ),
    );
  }
}

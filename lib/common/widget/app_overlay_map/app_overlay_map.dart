import 'package:flutter/material.dart';

import 'app_overlay_map_entry.dart';
import 'overlay_map_widget.dart';

class AppOverlayMap extends StatefulWidget {
  final Widget? child;

  const AppOverlayMap({
    super.key,
    required this.child,
  }) : assert(child != null);

  @override
  _AppOverlayMapState createState() => _AppOverlayMapState();
}

class _AppOverlayMapState extends State<AppOverlayMap> {
  late AppOverlayMapEntry _overlayMapEntry;

  @override
  void initState() {
    super.initState();
    _overlayMapEntry = AppOverlayMapEntry(
      builder: (BuildContext context) => Positioned(
        bottom: 0, // Position at the bottom
        right: 0, // Position at the right
        child: OverlayMapWidget.instance.widget ?? Container(),
      ),
    );
    OverlayMapWidget.instance.overlayMapEntry = _overlayMapEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          AppOverlayMapEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
          _overlayMapEntry,
        ],
      ),
    );
  }
}

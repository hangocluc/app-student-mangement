import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

T? _ambiguate<T>(T? value) => value;

class AppOverlayMapContainer extends StatefulWidget {
  final Widget child;
  final Completer<void>? completer;

  const AppOverlayMapContainer(
      {super.key, this.child = const SizedBox(), this.completer});

  @override
  State<AppOverlayMapContainer> createState() => AppOverlayMapContainerState();
}

class AppOverlayMapContainerState extends State<AppOverlayMapContainer>
    with SingleTickerProviderStateMixin {
  String? _status;

  bool get isPersistentCallbacks =>
      _ambiguate(SchedulerBinding.instance)!.schedulerPhase ==
      SchedulerPhase.persistentCallbacks;

  Future<void> show() {
    Completer<void> completer = Completer<void>();
    _ambiguate(SchedulerBinding.instance)!
        .addPostFrameCallback((_) => completer.complete());
    return completer.future;
  }

  Future<void> dismiss(bool animation) {
    Completer<void> completer = Completer<void>();
    _ambiguate(SchedulerBinding.instance)!
        .addPostFrameCallback((_) => completer.complete());
    return completer.future;
  }

  void updateStatus(String status) {
    if (_status == status) return;
    setState(() {
      _status = status;
    });
  }

  double _x = 0;
  double _y = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              top: _y,
              left: _x,
              child: Draggable(
                feedback: widget.child,
                onDragEnd: (details) {
                  setState(() {
                    _x = details.offset.dx;
                    _y = details.offset.dy;
                  });
                },
                child: widget.child,
              ),
            )
          ],
        ));
  }
}

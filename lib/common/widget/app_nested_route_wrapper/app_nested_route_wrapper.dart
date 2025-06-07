import 'package:flutter/material.dart';

class NestedRouteWrapper extends StatefulWidget {
  final RouteFactory onGenerateRoute;
  final GlobalKey<NavigatorState> navigationKey;
  final String initialRoute;
  final Function(String routeName)? onChangeScreen;

  const NestedRouteWrapper({
    super.key,
    required this.onGenerateRoute,
    required this.navigationKey,
    required this.initialRoute,
    this.onChangeScreen,
  });

  @override
  State<NestedRouteWrapper> createState() => _NestedRouteWrapperState();
}

class _NestedRouteWrapperState extends State<NestedRouteWrapper> {
  late String routeName;

  @override
  void initState() {
    super.initState();
    routeName = widget.initialRoute;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigationKey,
      initialRoute: widget.initialRoute,
      observers: [
        _CustomNavigatorObserver(
          onPop: (route) {
            final popRouteName = route?.settings.name;
            if (popRouteName != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  routeName = popRouteName;
                });
                widget.onChangeScreen?.call(routeName);
              });
            }
          },
          onPush: (route) {
            final pushRouteName = route.settings.name;
            if (pushRouteName != null) {
              // Sử dụng WidgetsBinding để cập nhật sau khi xây dựng hoàn tất
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  routeName = pushRouteName;
                });
                widget.onChangeScreen?.call(routeName);
              });
            }
          },
        ),
      ],
      onGenerateRoute: widget.onGenerateRoute,
    );
  }
}

class _CustomNavigatorObserver extends NavigatorObserver {
  final Function(Route? route) onPop;
  final Function(Route route) onPush;

  _CustomNavigatorObserver({
    required this.onPop,
    required this.onPush,
  });

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      onPush(route);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    onPop(previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      onPush(newRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    onPop(previousRoute);
  }
}

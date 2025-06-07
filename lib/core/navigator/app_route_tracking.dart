import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'navigator_service.dart';

class AppRouterTracking extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    if (route is PageRoute) {
      _getRouter(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _getRouter(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _getRouter(previousRoute);
    }
  }

  void _getRouter(PageRoute<dynamic> route) {
    GetIt.instance<NavigationService>().currentPath = route.settings.name;
  }
}

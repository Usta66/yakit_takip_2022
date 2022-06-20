import 'package:flutter/material.dart';

import 'navigation_route_services.dart';

class NavigationServices {
  static final NavigationServices _instance = NavigationServices._init();

  NavigationServices._init();

  static NavigationServices get instance => _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "navigator");

  get removAllOldRoutes {
    return (Route<dynamic> route) {
      return false;
    };
  }

  Future<T?> navigatePush<T>({required NavigationEnum path, Object? args}) {
    return navigatorKey.currentState!.pushNamed<T>(path.name, arguments: args);
  }

  Future<T?> navigateToReset<T>({required NavigationEnum path, Object? args}) async {
    return await navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(path.name, removAllOldRoutes, arguments: args);
  }
}

void goToViewPush<T>({required NavigationEnum path, void Function(T)? function, Object? args}) {
  NavigationServices.instance.navigatePush<T>(path: path, args: args).then((value) {
    if (function != null && value != null) {
      function(value);
    }
  });
}

void goToViewReset({required NavigationEnum path, Object? args}) {
  NavigationServices.instance.navigateToReset(path: path, args: args);
}

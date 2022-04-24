import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/navigation/navigation_enum.dart';

class NavigationServices {
  static final NavigationServices _instance = NavigationServices._init();

  NavigationServices._init();

  static NavigationServices get instance => _instance;

  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "navigator");

  Future<T?> navigatePush<T>({required NavigationEnum path, Object? args}) {
    return navigatorKey.currentState!.pushNamed<T>(path.name, arguments: args);
  }
}

void goToWiewPush<T>({required NavigationEnum path, void Function(T)? function, Object? args}) {
  NavigationServices.instance
      .navigatePush<T>(path: path, args: args)
      .then((value) {

        if(function!=null&&value!=null){
          function(value);

        }


    
  });
}

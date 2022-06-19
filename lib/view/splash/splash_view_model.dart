import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/navigation/navigation_route_services.dart';
import 'package:yakit_takip_2022/navigation/navigation_services.dart';

import '../../init/cache/enum_preferences_keys.dart';
import '../../init/cache/locale_maneger.dart';
import '../../services/database_service.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel() {
    control();
  }
  control() async {
    await DatabaseService.instance!.dbOpen();
    await Future.delayed(const Duration(seconds: 2));
    navigate();
  }

  Future<void> navigate() async {
    await LocaleManeger.prefrencesInit();

    bool? isOpen =
        LocaleManeger.instance.getBoolValue(EnumPreferencesKeys.ISFIRSTOPEN);

    if (isOpen == null || isOpen == false) {
      LocaleManeger.instance
          .setBoolValue(EnumPreferencesKeys.ISFIRSTOPEN, true);
      goToWiewPush(path: NavigationEnum.onboard);
    } else {
      goToWiewPush(path: NavigationEnum.aracListesi);
    }
  }
}

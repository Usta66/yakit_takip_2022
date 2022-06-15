// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class LottieConstants {
  static LottieConstants? _instance;

  static LottieConstants? get instance {
    _instance ??= LottieConstants._init();
    return _instance;
  }

  LottieConstants._init();
}

class AssetsConstants {
  static AssetsConstants? _instance;

  static AssetsConstants? get instance {
    return _instance ??= AssetsConstants._init();
  }

  AssetsConstants._init();

/*   final String ONBOARD_SVG1 = "assets/images/svg/onboard_1.svg";
 
  final String ONBOARD_SVG2 = "assets/images/svg/onboard_2.svg";

  final String ONBOARD_SVG3 = "assets/images/svg/onboard_3.svg"; */
}

class LocaleConstants {
  // ignore: constant_identifier_names
  static const TR_LOCALE = Locale("tr", "TR");
  // ignore: constant_identifier_names
  static const EN_LOCALE = Locale("en", "US");
  // ignore: constant_identifier_names
  static const LANG_PATH = "assets/lang";
}

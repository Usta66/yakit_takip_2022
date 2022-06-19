// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class LottieConstants {
  static LottieConstants? _instance;

  static LottieConstants? get instance {
    _instance ??= LottieConstants._init();
    return _instance;
  }

  LottieConstants._init();

  // ignore: non_constant_identifier_names
  final NOT_FOUND = "assets/lottie/not_found.json";
  // ignore: non_constant_identifier_names
  final BENZIN_DOLUM = "assets/lottie/benzin_dolum.json";

  final GAS_STATION = "assets/lottie/gas_station.json";
}

class AssetsConstants {
  static AssetsConstants? _instance;

  static AssetsConstants? get instance {
    return _instance ??= AssetsConstants._init();
  }

  AssetsConstants._init();

  // ignore: non_constant_identifier_names
  final CAR_1 = "assets/images/svg/car1.svg";
   final CHART_1 = "assets/images/svg/chart1.svg";
  // ignore: non_constant_identifier_names
  final CITIY_DRIVER = "assets/images/svg/city_driver.svg";
  // ignore: non_constant_identifier_names
  final MY_CAR = "assets/images/svg/my_car.svg";
  // ignore: non_constant_identifier_names
  final OFF_ROAD = "assets/images/svg/off_road.svg";
  // ignore: non_constant_identifier_names
  final VEHICLE_SALE = "assets/images/svg/vehicle_sale.svg";
}

class LocaleConstants {
  // ignore: constant_identifier_names
  static const TR_LOCALE = Locale("tr", "TR");
  // ignore: constant_identifier_names
  static const EN_LOCALE = Locale("en", "US");
  // ignore: constant_identifier_names
  static const LANG_PATH = "assets/lang";
}

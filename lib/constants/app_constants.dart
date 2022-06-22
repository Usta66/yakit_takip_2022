// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class LottieConstants {
  static LottieConstants? _instance;

  static LottieConstants? get instance {
    _instance ??= LottieConstants._init();
    return _instance;
  }

  LottieConstants._init();

  final NOT_FOUND = "assets/lottie/not_found.json";

  final BENZIN_DOLUM = "assets/lottie/benzin_dolum.json";

  final GAS_STATION = "assets/lottie/gas_station.json";
}

class AssetsConstants {
  static AssetsConstants? _instance;

  static AssetsConstants? get instance {
    return _instance ??= AssetsConstants._init();
  }

  AssetsConstants._init();

  final CAR_1 = "assets/images/svg/car1.svg";
  final CHART_1 = "assets/images/svg/chart1.svg";

  final CITIY_DRIVER = "assets/images/svg/city_driver.svg";

  final MY_CAR = "assets/images/svg/my_car.svg";

  final OFF_ROAD = "assets/images/svg/off_road.svg";

  final VEHICLE_SALE = "assets/images/svg/vehicle_sale.svg";
  final NO_IMAGE = "assets/images/jpg/no_image.jpg";
}

class LocaleConstants {
  // ignore: constant_identifier_names
  static const TR_LOCALE = Locale("tr", "TR");
  // ignore: constant_identifier_names
  static const EN_LOCALE = Locale("en", "US");
  // ignore: constant_identifier_names
  static const LANG_PATH = "assets/lang";
}

class StringConstants {
  static const String tlKm = " TL/KM";
  static const String km = " KM";
  static const String l100km = " L/100KM";
  static const String tl = " TL";
  static const String l = " L";
  static const String lKm = " L/KM";
}

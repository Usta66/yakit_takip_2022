import 'package:flutter/cupertino.dart';

import '../../constants/app_constants.dart';
import 'onboard_model.dart';

class OnboardViewModel extends ChangeNotifier {
  OnboardViewModel() {
    init();
  }
  List<OnboardModel> onboardItems = [];
  int curruntIndex = 0;

  void changeCurrentIndex(int value) {
    curruntIndex = value;
    notifyListeners();
  }

  void init() {
    onboardItems.add(OnboardModel(
        title: "Yakıt Verilerinizi Grafikler Uzerinden Takip",
        description: "Kaliteli Benzin",
        imagePath: AssetsConstants.instance!.CHART_1));

    onboardItems.add(OnboardModel(
        title: "Enson Benzin Fiyatı",
        description: "Benzin Çok Pahalı",
        imagePath: AssetsConstants.instance!.OFF_ROAD));
    onboardItems.add(OnboardModel(
        title: "LPG'de Ne Yakıyor Araba",
        description: "Çok Yakıyor ÇOk",
        imagePath: AssetsConstants.instance!.MY_CAR));
  }
}

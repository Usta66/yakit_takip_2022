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
        title: "Yakıt Verilerinizi Grafikler Uzerinden Takip Edin",
        description: "Yakit Alımlarınızı alım tarihi bazlı olarak fiyat, miktar, ortalama tüketimler(TL/KM - L/100KM) olarak görebilirsiniz.  ",
        imagePath: AssetsConstants.instance!.CHART_1));

    onboardItems.add(OnboardModel(
        title: "LPG'li Araçlarda Karma Yakıt Tüketiminizi Görün",
        description: "LPG'li araçlarda LPG ve benzin tüketimleri ayrı ayrı hesaplanarak bu değerlerden karma yakıt verisine ulaşılır.",
        imagePath: AssetsConstants.instance!.OFF_ROAD));
    onboardItems.add(OnboardModel(
        title: "Geçmiş Yakıt Verilerinizi Saklayın",
        description:
            "Araca ait tüm yakıt verileri kayıt edilerek kullanıcıya bütün ayrıntılarıyla gösterilir. Yakıt verileri üzerinde silme güncelleme işlemlerini yapabilirsiniz.",
        imagePath: AssetsConstants.instance!.MY_CAR));
  }
}

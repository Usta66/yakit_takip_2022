import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/app_constants.dart';
import '../../utils/locale_keys.g.dart';
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
        title: LocaleKeys.onboard_baslik1.tr(), description: LocaleKeys.onboard_aciklama1.tr(), imagePath: AssetsConstants.instance!.CHART_1));

    onboardItems.add(OnboardModel(
        title: LocaleKeys.onboard_baslik2.tr(), description: LocaleKeys.onboard_aciklama2.tr(), imagePath: AssetsConstants.instance!.OFF_ROAD));
    onboardItems.add(OnboardModel(
        title: LocaleKeys.onboard_baslik3.tr(), description: LocaleKeys.onboard_aciklama3.tr(), imagePath: AssetsConstants.instance!.MY_CAR));
  }
}

import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/view/home/home_view_model.dart';
import 'package:yakit_takip_2022/view/yakit_list/yakit_list_vie_model.dart';

import '../../model/car_model.dart';

class HomeAndYakitListViewModel extends ChangeNotifier {
  final CarModel carModel;
  late YakitListViewModel yakitListViewModel;
  late HomeViewModel homeViewModel;

  HomeAndYakitListViewModel({
    required this.carModel,
  }) {
    yakitListViewModel = YakitListViewModel(carModel: carModel);
    homeViewModel = HomeViewModel(carModel: carModel);
  }
}

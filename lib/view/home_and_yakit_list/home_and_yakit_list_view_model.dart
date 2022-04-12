import 'package:flutter/material.dart';

import '../../model/car_model.dart';

class HomeAndYakitListViewModel extends ChangeNotifier {
  final CarModel carModel;
  HomeAndYakitListViewModel({
    required this.carModel,
  });
}

import 'package:flutter/material.dart';

import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

class HomeViewModel extends ChangeNotifier {
  DatabaseService _dbService = DatabaseService.instance!;

  late TextEditingController controllerAdi, controllerYakitTuru;
  CarModel? carModel;

  doldur(CarModel carModel) {
    controllerAdi = TextEditingController(text: carModel.adi ?? "yok");
    controllerYakitTuru = TextEditingController(text: carModel.yakitTuru ?? "yok");
  }
}

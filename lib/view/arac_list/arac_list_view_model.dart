import 'package:flutter/material.dart';

import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

class AracListViewModel extends ChangeNotifier {
  late DatabaseService _dbServis;

  List<CarModel?> listCarModel = [];

  AracListViewModel() {
    _dbServis = DatabaseService.instance!;
    yaz();
  }

  Future<List<CarModel?>> getAracListesi() {
    return DatabaseService.instance!.getModelList<CarModel>();
  }

  Future<void> aracListesiniDoldur() async {
    listCarModel = await getAracListesi();
  }

  yaz() async {
    (await DatabaseService.instance!.getModelList<CarModel>()).forEach((element) {
      print(element);
    });
  }
}

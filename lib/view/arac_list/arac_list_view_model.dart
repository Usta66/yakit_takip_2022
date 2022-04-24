import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

class AracListViewModel extends ChangeNotifier {
  late DatabaseService _dbServis;
  List<CarModel?> listCarModel = [];

  set aracListesi(List<CarModel?> list) {
    listCarModel = list;
    notifyListeners();
  }

  AracListViewModel() {
    _dbServis = DatabaseService.instance!;

    aracListesiniDoldur();
  }

  Future<void> aracListesiniDoldur() async {
    aracListesi = await _dbServis.getModelList<CarModel>();
  }

  Future<int> modelInsert(CarModel carModel) {
    var result = _dbServis.insert<CarModel>(carModel);
    aracListesiniDoldur();

    return result;
  }

  Future<int> modelUpdate(CarModel carModel) {
    var result = _dbServis.update<CarModel>(carModel);
    aracListesiniDoldur();
    return result;
  }

  Future<int> delete(CarModel carModel) {
    if (carModel.id != null) {
      var resualt = _dbServis.delete<CarModel>(carModel.id!);
      aracListesiniDoldur();
      return resualt;
    } else {
      throw ("delet carmosel id null");
    }
  }
}

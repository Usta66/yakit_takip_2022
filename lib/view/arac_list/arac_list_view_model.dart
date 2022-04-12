import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

class AracListViewModel extends ChangeNotifier {
  static AracListViewModel? _instance;

  static AracListViewModel? get instance {
    _instance ??= AracListViewModel._init();

    return _instance;
  }

  late DatabaseService _dbServis;
  List<CarModel?> listCarModel = [];

  set aracListesi(List<CarModel?> list) {
    listCarModel = list;
    // notifyListeners();
  }

  AracListViewModel._init() {
    _dbServis = DatabaseService.instance!;

    aracListesiniDoldur();
  }

  Future<List<CarModel?>> getAracListesi() {
    return _dbServis.getModelList<CarModel>();
  }

  Future<void> aracListesiniDoldur() async {
    aracListesi = await getAracListesi();
  }
}

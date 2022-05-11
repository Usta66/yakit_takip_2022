import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

import '../../model/car_model.dart';
import '../../model/yakit_hesap_model.dart';
import '../../model/yakit_islem_model.dart';

class HomeAndYakitListViewModel extends ChangeNotifier {
  late CarModel carModel;

  final DatabaseService _dbServis = DatabaseService.instance!;

  List<YakitIslemModel?> listYakitIslemModel = [];
  late YakitHesapModel yakitHesapModel = YakitHesapModel(listYakitIslemModel: listYakitIslemModel, carModel: carModel);

  HomeAndYakitListViewModel({
    required this.carModel,
  }) {
    yakitListesiniDoldur();

    ;
  }

  Future<int> modelInsert(YakitIslemModel yakitIslemModel) async {
    var result = await _dbServis.insert<YakitIslemModel>(yakitIslemModel);

    await yakitListesiniDoldur();

    carModel = carModel.copyWith(
      aracKm: double.tryParse(yakitHesapModel.sonKm),
    );

    _dbServis.update<CarModel>(carModel);

    return result;
  }

  Future<int> modelUpdate(YakitIslemModel yakitIslemModel) {
    var result = _dbServis.update<YakitIslemModel>(yakitIslemModel);
    yakitListesiniDoldur();

    return result;
  }

  Future<List<YakitIslemModel?>> yakitListesiniDoldur() async {
    var result = await _dbServis.getAracYakitListesi(aracId: carModel.id!);

    listYakitIslemModel = result;

    yakitHesapModel = YakitHesapModel(listYakitIslemModel: listYakitIslemModel, carModel: carModel);

    notifyListeners();

    return result;
  }

  Future<int> delete(YakitIslemModel yakitIslemModel) {
    if (yakitIslemModel.id != null) {
      var resualt = _dbServis.delete<YakitIslemModel>(yakitIslemModel.id!);
      yakitListesiniDoldur();
      return resualt;
    } else {
      throw ("delet carmosel id null");
    }
  }
}

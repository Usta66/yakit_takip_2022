import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

import '../../model/car_model.dart';
import '../../model/yakit_hesap_model.dart';
import '../../model/yakit_islem_model.dart';

class HomeAndYakitListViewModel extends ChangeNotifier {
  final CarModel carModel;

  final DatabaseService _dbServis = DatabaseService.instance!;
  late TextEditingController controllerAdi, controllerYakitTuru, controllerMiktar;
  List<YakitIslemModel?> listYakitIslemModel = [];
  late YakitHesapModel yakitHesapModel = YakitHesapModel(listYakitIslemModel: listYakitIslemModel, carModel: carModel);

  HomeAndYakitListViewModel({
    required this.carModel,
  }) {
    controllerAdi = TextEditingController(text: carModel.adi ?? "yok");
    controllerYakitTuru = TextEditingController(text: carModel.yakitTuru!.name);
    controllerMiktar = TextEditingController();

    yakitListesiniDoldur();

    ;
  }

  Future<int> modelInsert(YakitIslemModel yakitIslemModel) {
    var result = _dbServis.insert<YakitIslemModel>(yakitIslemModel);

    yakitListesiniDoldur();

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

    controllerMiktar.text = yakitHesapModel.getTlKm().toStringAsFixed(2);

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

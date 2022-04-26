import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

import '../../model/car_model.dart';
import '../../model/yakit_islem_model.dart';

class HomeAndYakitListViewModel extends ChangeNotifier {
  final CarModel carModel;

  final DatabaseService _dbServis = DatabaseService.instance!;
  late TextEditingController controllerAdi, controllerYakitTuru, controllerMiktar;
  List<YakitIslemModel?> listYakitIslemModel = [];

  HomeAndYakitListViewModel({
    required this.carModel,
  }) {
    controllerAdi = TextEditingController(text: carModel.adi ?? "yok");
    controllerYakitTuru = TextEditingController(text: carModel.yakitTuru ?? "yok");
    controllerMiktar = TextEditingController();

    yakitListesiniDoldur();
  }

  Future<int> modelInsert(YakitIslemModel yakitIslemModel) {
    yakitIslemModel = yakitIslemModel.copyWith(aracId: carModel.id);

    var result = _dbServis.insert<YakitIslemModel>(yakitIslemModel);

    yakitListesiniDoldur();
    //homeViewModel.yakitListesiniDoldur();

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

    tuketilenToplamLpg();

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

  double tuketilenToplamLpg() {
    double tuketilenLpgMiktari = 0;

    if (listYakitIslemModel.isNotEmpty) {
      var result = listYakitIslemModel.where((element) => element!.yakitTuru == "LPG");

      for (var element in result) {
        if (element!.miktari != null) {
          tuketilenLpgMiktari = tuketilenLpgMiktari + element.miktari!;
        }
      }
    }

    controllerMiktar = TextEditingController(text: tuketilenLpgMiktari.toString());

    return tuketilenLpgMiktari;
  }
}

import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

import '../arac_list/arac_list_view_model.dart';

class YakitEklemeViewModel extends ChangeNotifier {
  DatabaseService _dbservise = DatabaseService.instance!;

  late YakitIslemModel yakitIslemModel;
  late bool isNew;
  late TextEditingController controllerKm, controllerYakitTuru, controllerToplamtutar, controllerBirimFiyat, controllerMiktar;
  final AracListViewModel _aracListViewModel = AracListViewModel.instance!;
  final DatabaseService _dbServis = DatabaseService.instance!;

  YakitEklemeViewModel.addNew() {
    isNew = true;
    yakitIslemModel = YakitIslemModel();
    controllerKm = TextEditingController();
    controllerYakitTuru = TextEditingController();
    controllerToplamtutar = TextEditingController();
    controllerBirimFiyat = TextEditingController();
    controllerMiktar = TextEditingController();
  }
  YakitEklemeViewModel.show({required this.yakitIslemModel}) {
    isNew = false;
    controllerKm = TextEditingController(text: yakitIslemModel.aracKm!.toStringAsFixed(2));
    controllerYakitTuru = TextEditingController(text: yakitIslemModel.yakitTuru);
    controllerLpgDepo = TextEditingController(text: yakitIslemModel.aracLpgDepo.toString());
    controllerAracDepo = TextEditingController(text: yakitIslemModel.aracDepo.toString());
  }

  CarModel modeliHazirla() {
    return yakitIslemModel = yakitIslemModel.copyWith(
        adi: controllerAdi.text.trim().toUpperCase(),
        yakitTuru: controllerYakitTuru.text.trim().toUpperCase(),
        aracDepo: double.tryParse(controllerAracDepo.text.trim().toUpperCase()),
        aracLpgDepo: double.tryParse(controllerLpgDepo.text.trim().toUpperCase()));
  }

  Future<int> modelInsert(CarModel carModel) {
    var resault = _dbServis.insert<CarModel>(carModel);

    return resault;
  }

  addOrSet() {
    modeliHazirla();
    isNew ? modelInsert(yakitIslemModel) : modelUpdate(yakitIslemModel);
    _aracListViewModel.aracListesiniDoldur();
  }

  Future<int> modelUpdate(CarModel carModel) {
    return _dbServis.update<CarModel>(carModel);
  }

  Future<int> delete() {
    if (yakitIslemModel.id != null) {
      var resualt = _dbServis.delete<CarModel>(yakitIslemModel.id!);
      _aracListViewModel.aracListesiniDoldur();
      return resualt;
    } else {
      throw ("delet carmosel id null");
    }
  }
}

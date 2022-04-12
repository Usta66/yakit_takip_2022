import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/services/database_service.dart';
import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';

import '../../model/car_model.dart';

class AddNewCarViewModel extends ChangeNotifier {
  late CarModel carModel;
  late bool isNew;
  late TextEditingController controllerAdi, controllerYakitTuru, controllerLpgDepo, controllerAracDepo;
  final AracListViewModel _aracListViewModel = AracListViewModel.instance!;
  final DatabaseService _dbServis = DatabaseService.instance!;

  AddNewCarViewModel.addNew() {
    isNew = true;
    carModel = CarModel();
    controllerAdi = TextEditingController();
    controllerYakitTuru = TextEditingController();
    controllerLpgDepo = TextEditingController();
    controllerAracDepo = TextEditingController();
  }
  AddNewCarViewModel.show({required this.carModel}) {
    isNew = false;
    controllerAdi = TextEditingController(text: carModel.adi);
    controllerYakitTuru = TextEditingController(text: carModel.yakitTuru);
    controllerLpgDepo = TextEditingController(text: carModel.aracLpgDepo.toString());
    controllerAracDepo = TextEditingController(text: carModel.aracDepo.toString());
  }

  CarModel modeliHazirla() {
    return carModel = carModel.copyWith(
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
    isNew ? modelInsert(carModel) : modelUpdate(carModel);
    _aracListViewModel.aracListesiniDoldur();
  }

  Future<int> modelUpdate(CarModel carModel) {
    return _dbServis.update<CarModel>(carModel);
  }

  Future<int> delete() {
    if (carModel.id != null) {
      var resualt = _dbServis.delete<CarModel>(carModel.id!);
      _aracListViewModel.aracListesiniDoldur();
      return resualt;
    } else {
      throw ("delet carmosel id null");
    }
  }
}

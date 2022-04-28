import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';

import 'package:yakit_takip_2022/services/database_service.dart';
import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';

import '../../model/car_model.dart';

class AddNewCarViewModel extends ChangeNotifier {
  late CarModel carModel;
  late bool isNew;
  late TextEditingController controllerAdi, controllerYakitTuru, controllerLpgDepo, controllerAracDepo;

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
    controllerYakitTuru = TextEditingController(text: carModel.yakitTuru!.name);
    controllerLpgDepo = TextEditingController(text: carModel.aracLpgDepo.toString());
    controllerAracDepo = TextEditingController(text: carModel.aracDepo.toString());
  }

  CarModel modeliHazirla() {
    return carModel = carModel.copyWith(
        adi: controllerAdi.text.trim().toUpperCase(),
        yakitTuru: (controllerYakitTuru.text.trim()).YakitTuruValu,
        aracDepo: double.tryParse(controllerAracDepo.text.trim().toUpperCase()),
        aracLpgDepo: double.tryParse(controllerLpgDepo.text.trim().toUpperCase()));
  }
}

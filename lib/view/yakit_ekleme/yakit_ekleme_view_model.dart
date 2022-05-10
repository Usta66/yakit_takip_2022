import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/utils/date_time_extension.dart';

class YakitEklemeViewModel extends ChangeNotifier {
  late YakitIslemModel yakitIslemModel;
  late bool isNew;
  late CarModel carModel;
  late TextEditingController controllerKm, controllerYakitTuru, controllerToplamtutar, controllerBirimFiyat, controllerMiktar, controllerAlisTarihi;

  YakitEklemeViewModel.addNew({required this.carModel}) {
    isNew = true;
    yakitIslemModel = YakitIslemModel();
    controllerKm = TextEditingController();
    controllerYakitTuru = TextEditingController(text: carModel.yakitTuru!.name.toUpperCase());
    controllerToplamtutar = TextEditingController();
    controllerBirimFiyat = TextEditingController();
    controllerMiktar = TextEditingController();
    controllerAlisTarihi = TextEditingController();
  }
  YakitEklemeViewModel.show({required this.yakitIslemModel, required this.carModel}) {
    isNew = false;
    controllerKm = TextEditingController(text: yakitIslemModel.aracKm == null ? "0" : yakitIslemModel.aracKm!.toStringAsFixed(2));
    controllerYakitTuru = TextEditingController(text: yakitIslemModel.yakitTuru!.name);
    controllerToplamtutar = TextEditingController(text: yakitIslemModel.tutar == null ? "0" : yakitIslemModel.tutar!.toStringAsFixed(2));
    controllerBirimFiyat = TextEditingController(text: yakitIslemModel.fiyati == null ? "0" : yakitIslemModel.fiyati!.toStringAsFixed(2));
    controllerMiktar = TextEditingController(text: yakitIslemModel.miktari == null ? "0" : yakitIslemModel.miktari!.toString());
    controllerAlisTarihi = TextEditingController(text: yakitIslemModel.alisTarihi!.stringValue);
  }

  YakitIslemModel modeliHazirla() {
    return yakitIslemModel = yakitIslemModel.copyWith(
      alisTarihi: controllerAlisTarihi.text.stringToDateTime,
      aracId: carModel.id,
      aracKm: double.tryParse(controllerKm.text.trim()),
      fiyati: double.tryParse(controllerBirimFiyat.text.trim()),
      tutar: double.tryParse(controllerToplamtutar.text.trim()),
      miktari: double.tryParse(controllerMiktar.text.trim()),
      yakitTuru: (controllerYakitTuru.text.trim()).YakitTuruValu,
    );
  }
}

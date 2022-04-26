import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';

class YakitEklemeViewModel extends ChangeNotifier {
  late YakitIslemModel yakitIslemModel;
  late bool isNew;
  late TextEditingController controllerKm, controllerYakitTuru, controllerToplamtutar, controllerBirimFiyat, controllerMiktar;

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
    controllerKm = TextEditingController(text: yakitIslemModel.aracKm == null ? "0" : yakitIslemModel.aracKm!.toStringAsFixed(2));
    controllerYakitTuru = TextEditingController(text: yakitIslemModel.yakitTuru);
    controllerToplamtutar = TextEditingController(text: yakitIslemModel.tutar == null ? "0" : yakitIslemModel.tutar!.toStringAsFixed(2));
    controllerBirimFiyat = TextEditingController(text: yakitIslemModel.fiyati == null ? "0" : yakitIslemModel.fiyati!.toStringAsFixed(2));
    controllerMiktar = TextEditingController(text: yakitIslemModel.miktari == null ? "0" : yakitIslemModel.miktari!.toString());
  }

  YakitIslemModel modeliHazirla() {
    return yakitIslemModel = yakitIslemModel.copyWith(
      aracKm: double.tryParse(controllerKm.text.trim()),
      fiyati: double.tryParse(controllerBirimFiyat.text.trim()),
      tutar: double.tryParse(controllerToplamtutar.text.trim()),
      miktari: double.tryParse(controllerMiktar.text.trim()),
      yakitTuru: controllerYakitTuru.text.trim().toUpperCase(),
    );
  }
}

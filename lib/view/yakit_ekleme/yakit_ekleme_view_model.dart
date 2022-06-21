import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/model/yakit_hesap_model.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/utils/date_time_extension.dart';

class YakitEklemeViewModel extends ChangeNotifier {
  late YakitIslemModel yakitIslemModel;
  List<YakitIslemModel?> yakitIslemModelList = [];
  final YakitHesapModel yakitHesapModel;
  late int index;

  late bool isNew;
  late CarModel carModel;
  late TextEditingController controllerKm,
      controllerYakitTuru,
      controllerToplamTutar,
      controllerBirimFiyat,
      controllerMiktar,
      controllerAlisTarihi,
      controllerAlisSaati;

  final formKey = GlobalKey<FormState>();

  YakitEklemeViewModel.addNew({required this.carModel, required this.yakitHesapModel}) {
    isNew = true;
    yakitIslemModel = YakitIslemModel();
    controllerKm = TextEditingController();
    controllerYakitTuru = TextEditingController(text: carModel.yakitTuru!.name.toUpperCase().tr());
    controllerToplamTutar = TextEditingController();
    controllerBirimFiyat = TextEditingController();
    controllerMiktar = TextEditingController();
    controllerAlisTarihi = TextEditingController(text: DateTime.now().stringValue);
    controllerAlisSaati = TextEditingController(text: TimeOfDay.now().stringValue);
  }
  YakitEklemeViewModel.show({required this.yakitIslemModel, required this.carModel, required this.yakitHesapModel, required this.index}) {
    YakitHesapModel.getListYakitislemModel(carModel).then((value) {
      yakitIslemModelList = value;
      notifyListeners();
    });
    isNew = false;

    controllerKm = TextEditingController(text: yakitIslemModel.aracKm == null ? "0" : yakitIslemModel.aracKm!.toStringAsFixed(2));
    controllerYakitTuru = TextEditingController(text: yakitIslemModel.yakitTuru!.name.toUpperCase().tr());
    controllerToplamTutar = TextEditingController(text: yakitIslemModel.tutar == null ? "0" : yakitIslemModel.tutar!.toStringAsFixed(2));
    controllerBirimFiyat = TextEditingController(text: yakitIslemModel.fiyati == null ? "0" : yakitIslemModel.fiyati!.toStringAsFixed(2));
    controllerMiktar = TextEditingController(text: yakitIslemModel.miktari == null ? "0" : yakitIslemModel.miktari!.toString());
    controllerAlisTarihi = TextEditingController(text: yakitIslemModel.alisTarihi!.stringValue);
    controllerAlisSaati = TextEditingController(text: yakitIslemModel.alisSaati!.stringValue);
  }

  init() async {
    yakitIslemModelList = await YakitHesapModel.getListYakitislemModel(carModel);
  }

  YakitIslemModel modeliHazirla() {
    return yakitIslemModel = yakitIslemModel.copyWith(
      alisTarihi: controllerAlisTarihi.text.stringToDateTime,
      alisSaati: controllerAlisSaati.text.stringFromTimeOfDay,
      aracId: carModel.id,
      aracKm: double.tryParse(controllerKm.text.trim()),
      fiyati: double.tryParse(controllerBirimFiyat.text.trim()),
      tutar: double.tryParse(controllerToplamTutar.text.trim()),
      miktari: double.tryParse(controllerMiktar.text.trim()),
      yakitTuru: (controllerYakitTuru.text.trim()).YakitTuruValu,
    );
  }

  BirOncekiBirSonrakiKmModel birOncekiBirSonrakiKmHesapla() {
    double? birOnceki, birSonraki;
    if (index != 0 && yakitIslemModelList.isNotEmpty) {
      birOnceki = yakitIslemModelList[index - 1]!.aracKm;
    } else {
      birOnceki = null;
    }

    if (yakitIslemModelList.isNotEmpty && yakitIslemModelList.length != index + 1) {
      birSonraki = yakitIslemModelList[index + 1]!.aracKm;
    } else {
      birSonraki = null;
    }

    return BirOncekiBirSonrakiKmModel(birOnceki: birOnceki, birSonraki: birSonraki);
  }

  void yakitMiktariHesapla() {
    double fiyat = double.tryParse(controllerBirimFiyat.text.trim()) ?? 1;
    double tutar = double.tryParse(controllerToplamTutar.text.trim()) ?? 1;
    num miktar = tutar / fiyat;
    controllerMiktar.text = miktar.toStringAsFixed(2);
  }
}

class BirOncekiBirSonrakiKmModel {
  final double? birOnceki;
  final double? birSonraki;

  BirOncekiBirSonrakiKmModel({this.birOnceki, this.birSonraki});
}

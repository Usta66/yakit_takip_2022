import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/services/database_service.dart';
import 'package:yakit_takip_2022/view/home/home_view_model.dart';
import 'package:yakit_takip_2022/view/yakit_list/yakit_list_vie_model.dart';

import '../../model/car_model.dart';
import '../arac_list/arac_list_view_model.dart';

class YakitEklemeViewModel extends ChangeNotifier {
  DatabaseService _dbservis = DatabaseService.instance!;

  late YakitIslemModel yakitIslemModel;
  late bool isNew;
  late TextEditingController controllerKm, controllerYakitTuru, controllerToplamtutar, controllerBirimFiyat, controllerMiktar;
 // final AracListViewModel _aracListViewModel = AracListViewModel.instance!;
  final DatabaseService _dbServis = DatabaseService.instance!;
  late CarModel carModel;
  final YakitListViewModel yakitListViewModel;
  final HomeViewModel homeViewModel;

  YakitEklemeViewModel.addNew({required this.homeViewModel, required this.yakitListViewModel, required this.carModel}) {
    isNew = true;
    print("carModel.id");
    print(carModel.id);
    yakitIslemModel = YakitIslemModel();
    controllerKm = TextEditingController();
    controllerYakitTuru = TextEditingController();
    controllerToplamtutar = TextEditingController();
    controllerBirimFiyat = TextEditingController();
    controllerMiktar = TextEditingController();
  }
  YakitEklemeViewModel.show({required this.homeViewModel, required this.yakitListViewModel, required this.yakitIslemModel, required this.carModel}) {
    isNew = false;
    controllerKm = TextEditingController(text: yakitIslemModel.aracKm!.toStringAsFixed(2));
    controllerYakitTuru = TextEditingController(text: yakitIslemModel.yakitTuru);
    controllerToplamtutar = TextEditingController(text: yakitIslemModel.tutar!.toStringAsFixed(2));
    controllerBirimFiyat = TextEditingController(text: yakitIslemModel.fiyati!.toStringAsFixed(2));
  }

  YakitIslemModel modeliHazirla() {
    return yakitIslemModel = yakitIslemModel.copyWith(
      aracId: carModel.id,
      aracKm: double.tryParse(controllerKm.text.trim()),
      fiyati: double.tryParse(controllerBirimFiyat.text.trim()),
      tutar: double.tryParse(controllerToplamtutar.text.trim()),
      miktari: double.tryParse(controllerMiktar.text.trim()),
      yakitTuru: controllerYakitTuru.text.trim().toUpperCase(),
    );
  }

  Future<int> modelInsert(YakitIslemModel yakitIslemModel) {
    var resault = _dbServis.insert<YakitIslemModel>(yakitIslemModel);
    yakitListViewModel.yakitListesiniDoldur();

    aracGuncelle();
    homeViewModel.aracGuncelle();

    return resault;
  }

  addOrSet() {
    modeliHazirla();
    isNew ? modelInsert(yakitIslemModel) : modelUpdate(yakitIslemModel);
    //_aracListViewModel.aracListesiniDoldur();
  }

  Future<int> modelUpdate(YakitIslemModel yakitIslemModel) {
    return _dbServis.update<YakitIslemModel>(yakitIslemModel);
  }

  Future<int> delete() {
    if (yakitIslemModel.id != null) {
      var resualt = _dbServis.delete<CarModel>(yakitIslemModel.id!);
     // _aracListViewModel.aracListesiniDoldur();
      return resualt;
    } else {
      throw ("delet carmosel id null");
    }
  }

  aracGuncelle() {
    _dbservis.update<CarModel>(carModel.copyWith(adi: "88888"));
  }
}

import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/services/database_service.dart';
import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';

import '../../model/car_model.dart';
import '../../model/yakit_hesap_model.dart';
import '../../model/yakit_islem_model.dart';

class HomeAndYakitListViewModel extends ChangeNotifier {
  late CarModel carModel;
  late YakitHesapModel yakitHesapModel;

  final DatabaseService _dbServis = DatabaseService.instance!;
  final AracListViewModel aracListViewModel;

  late List<YakitIslemModel?> listYakitIslemModel;

  HomeAndYakitListViewModel({required this.carModel, required this.aracListViewModel}) {
    yakitListesiniDoldur();
  }

  Future<List<YakitIslemModel?>> yakitListesiniDoldur() async {
    listYakitIslemModel = await YakitHesapModel.getListYakitislemModel(carModel);

    yakitHesapModel = YakitHesapModel(carModel: carModel, listYakitIslemModel: listYakitIslemModel);

    notifyListeners();

    return listYakitIslemModel;
  }

  Future<int> modelInsert(YakitIslemModel yakitIslemModel) async {
    var result = await _dbServis.insert<YakitIslemModel>(yakitIslemModel);

    await aracModelUpdate();

    return result;
  }

  Future<int> modelUpdate(YakitIslemModel yakitIslemModel) async {
    print(yakitIslemModel.imagePath);
    var result = _dbServis.update<YakitIslemModel>(yakitIslemModel);
    await aracModelUpdate();

    return result;
  }

  Future<int> delete(YakitIslemModel yakitIslemModel) async {
    if (yakitIslemModel.id != null) {
      var resualt = _dbServis.delete<YakitIslemModel>(yakitIslemModel.id!);
      await aracModelUpdate();

      return resualt;
    } else {
      throw ("delet carmodel id null");
    }
  }

  Future<void> aracModelUpdate() async {
    await yakitListesiniDoldur();

    carModel = carModel.copyWith(aracKm: double.tryParse(yakitHesapModel.sonKm), ortalamaTl: double.tryParse(yakitHesapModel.tLKm));

    _dbServis.update<CarModel>(carModel);

    aracListViewModel.aracListesiniDoldur();
  }

  double? mesafeHesapla(int index) {
    double? mesafe;

    if (listYakitIslemModel.length > index + 1) {
      mesafe = listYakitIslemModel[index + 1]!.aracKm! - (listYakitIslemModel[index]!.aracKm!);
    } else {
      mesafe = null;
    }
    return mesafe;
  }
}

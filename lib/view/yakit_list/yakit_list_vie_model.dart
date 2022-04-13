import 'package:flutter/material.dart';

import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

import '../../model/car_model.dart';

class YakitListViewModel extends ChangeNotifier {
  final DatabaseService _dbservis = DatabaseService.instance!;

  List<YakitIslemModel?> listYakitIslemModel = [];
  late CarModel carModel;
  YakitListViewModel({
    required this.carModel,
  }) {
    print(carModel.id);
    yakitListesiniDoldur();
  }

  Future<List<YakitIslemModel?>> getYakitListesi() async {
    return await _dbservis.getAracYakitListesi(aracId: carModel.id!);
  }

  Future<void> yakitListesiniDoldur() async {
    print("yakıtListesiniDoldur");
    listYakitIslemModel = await getYakitListesi();
  }
}

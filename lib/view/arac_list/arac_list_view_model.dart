import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

class AracListViewModel extends ChangeNotifier {
  late DatabaseService _dbServis;

  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  List<CarModel?> listCarModel = [];

  set aracListesi(List<CarModel?> list) {
    listCarModel = list;
    notifyListeners();
  }

  AracListViewModel() {
    _dbServis = DatabaseService.instance!;

    aracListesiniDoldur();
  }

  Future<void> aracListesiniDoldur() async {
    aracListesi = await _dbServis.getModelList<CarModel>();
  }

  Future<int> modelInsert(CarModel carModel) {
    var result = _dbServis.insert<CarModel>(carModel);
    aracListesiniDoldur();

    return result;
  }

  Future<int> modelUpdate(CarModel carModel) {
    var result = _dbServis.update<CarModel>(carModel);
    aracListesiniDoldur();
    return result;
  }

  delete(CarModel carModel) async {
    showDialog<bool>(
        context: scaffoldKey.currentState!.context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Araca Ait Bütün Veriler Silinecektir?',
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              ButtonBar(
                children: [
                  ElevatedButton(
                    child: const Text("TAMAM"),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  ElevatedButton(
                    child: const Text("İPTAL"),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ],
              )
            ]),
          );
        }).then((value) async {
      if (carModel.id != null && value != null && value) {
        await _dbServis.aracaAitTumYakitlariSil(carModel.id!);
        await _dbServis.delete<CarModel>(carModel.id!);
        aracListesiniDoldur();
      }
    });
  }
}

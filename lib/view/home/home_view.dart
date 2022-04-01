import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/model/car_model.dart';

import '../../services/database_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DatabaseService.instance!.dbOpen();

          CarModel carModel = CarModel(
              adi: "deneme",
              aracDepo: 12,
              aracKm: 21,
              aracLpgDepo: 12,
              imagePath: "sasd",
              mevcutLpgMiktari: 21,
              mevcutYakitMiktari: 21,
              ortalamaKrs: 21,
              ortalamaLitre: 2,
              yakitTuru: "lpg");

          DatabaseService.instance!.insert<CarModel>(carModel);

          (await DatabaseService.instance!.getModelList<CarModel>()).forEach((element) {});

          print((await DatabaseService.instance!.getModel<CarModel>(1)).toString());
        },
      ),
    );
  }
}

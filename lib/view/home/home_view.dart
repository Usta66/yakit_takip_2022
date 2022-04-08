import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/components/base_text_field.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/view/home/home_view_model.dart';

import '../../services/database_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarModel carModel = ModalRoute.of(context)!.settings.arguments as CarModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(child: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          value.doldur(carModel);

          return Column(
            children: [
              BaseTextField(controller: value.controllerAdi),
              BaseTextField(
                controller: value.controllerYakitTuru,
              )
            ],
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
      ),
    );
  }
}

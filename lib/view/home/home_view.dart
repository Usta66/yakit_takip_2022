import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/base_text_field.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view.dart';
import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view_model.dart';
import 'package:yakit_takip_2022/view/home/home_view_model.dart';

import '../../services/database_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final HomeViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: SingleChildScrollView(child: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            return Column(
              children: [
                BaseTextField(controller: value.controllerAdi),
                BaseTextField(
                  controller: value.controllerYakitTuru,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewCarView(
                                  viewModel: AddNewCarViewModel.show(
                                      carModel: viewModel.carModel))));
                    },
                    child: Text("guncelle")),
              ],
            );
          },
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {},
        ),
      ),
    );
  }
}

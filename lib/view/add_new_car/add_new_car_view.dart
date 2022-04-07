import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/base_text_field.dart';
import 'package:yakit_takip_2022/services/database_service.dart';
import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view_model.dart';
import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';

import '../../model/car_model.dart';

class AddNewCarView extends StatelessWidget {
  const AddNewCarView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final AddNewCarViewModel viewModel;
  @override
  Widget build(BuildContext context) {

    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
            appBar: AppBar(title: const Text("Yeni Araç Ekle")),
            body: SingleChildScrollView(
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(1),
                      child: Wrap(
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: [
                          BaseTextField(
                              hintText: "Adı",
                              controller: viewModel.controllerAdi),
                          BaseTextField(
                              hintText: "Yakıt Türü",
                              controller: viewModel.controllerYakitTuru),
                          BaseTextField(
                              hintText: "LPG Depo Kapasite",
                              controller: viewModel.controllerLpgDepo),
                          BaseTextField(
                              hintText: "Akaryakıt Depo Kapasite",
                              controller: viewModel.controllerAracDepo),
                          Center(
                            child: Consumer<AracListViewModel>(
                              builder: (context, value, child) {
                                return ElevatedButton(
                                    onPressed: () async {
                                      viewModel.isNew
                                          ? viewModel.addOrSet()
                                          : viewModel.delete();

                                      value.aracListesiniDoldur();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                        viewModel.isNew ? "Kaydet" : "Sil"));
                              },
                            ),
                          )
                        ],
                      ))),
            )));
  }
}

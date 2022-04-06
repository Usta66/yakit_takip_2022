import 'package:flutter/material.dart';

import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/base_text_field.dart';
import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view_model.dart';

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
                          BaseTextField(hintText: "Adı"),
                          BaseTextField(hintText: "Yakıt Türü"),
                        ],
                      ))),
            )));
  }
}

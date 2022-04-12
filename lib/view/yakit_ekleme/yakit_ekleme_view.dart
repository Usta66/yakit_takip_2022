import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/view/yakit_ekleme/yakit_ekleme_view_model.dart';

import '../../components/yakit_ekleme_text_form_field.dart';

class YakitEklemeView extends StatelessWidget {
  const YakitEklemeView({Key? key, required this.viewModel}) : super(key: key);

  final YakitEklemeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Yakit Ekleme"),
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              const YakitEklemeTextFormField(icon: Icons.ac_unit_rounded, text: "ARAÇ KM", suffixTex: "KM"),
              const YakitEklemeTextFormField(icon: Icons.ac_unit_rounded, text: "YAKIT TÜRÜ"),
              const YakitEklemeTextFormField(icon: Icons.ac_unit_rounded, text: "Toplam Tutar", suffixTex: "TL"),
              const YakitEklemeTextFormField(icon: Icons.ac_unit_rounded, text: "birim Fiyat", suffixTex: "TL"),
              const YakitEklemeTextFormField(
                icon: Icons.ac_unit_rounded,
                text: "Miktar",
                suffixTex: "L",
              ),
              ElevatedButton(onPressed: () {}, child: Text("EKLE"))
            ],
          )),
        ));
  }
}

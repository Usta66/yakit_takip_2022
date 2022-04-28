import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/yakit_turu_secim_dialog.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/view/yakit_ekleme/yakit_ekleme_view_model.dart';

import '../../components/yakit_ekleme_text_form_field.dart';
import '../../model/delet_model.dart';

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
              YakitEklemeTextFormField(icon: Icons.ac_unit_rounded, text: "ARAÇ KM", suffixTex: "KM", controller: viewModel.controllerKm),
              YakitEklemeTextFormField(
                icon: Icons.ac_unit_rounded,
                text: "YAKIT TÜRÜ",
                controller: viewModel.controllerYakitTuru,
                readOnly: true,
                onTap: () {
                  if (viewModel.carModel.yakitTuru == YakitTuruEnum.LPG) {
                    showDialog<YakitTuruEnum>(
                        context: context,
                        builder: (context) {
                          return YakitTuruSecimDialog(isLpg: true);
                        }).then((value) {
                      if (value != null) {
                        viewModel.controllerYakitTuru.text = value.name.toUpperCase();
                      }
                    });
                  }
                },
              ),
              YakitEklemeTextFormField(
                  icon: Icons.ac_unit_rounded, text: "Toplam Tutar", suffixTex: "TL", controller: viewModel.controllerToplamtutar),
              YakitEklemeTextFormField(
                icon: Icons.ac_unit_rounded,
                text: "Birim Fiyat",
                suffixTex: "TL",
                controller: viewModel.controllerBirimFiyat,
              ),
              YakitEklemeTextFormField(
                icon: Icons.ac_unit_rounded,
                text: "Miktar",
                suffixTex: "L",
                controller: viewModel.controllerMiktar,
              ),
              Center(
                child: viewModel.isNew
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.pop<YakitIslemModel>(context, viewModel.modeliHazirla());
                        },
                        child: Text("EKLE"))
                    : Row(children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop<DeletModel>(context, DeletModel(model: viewModel.modeliHazirla(), isDelet: false));
                            },
                            child: Text("Güncelle")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop<DeletModel>(context, DeletModel(model: viewModel.modeliHazirla(), isDelet: true));
                            },
                            child: Text("Sil"))
                      ]),
              )
            ],
          )),
        ));
  }
}

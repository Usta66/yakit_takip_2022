import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/yakit_turu_secim_dialog.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/utils/date_time_extension.dart';

import 'package:yakit_takip_2022/view/yakit_ekleme/yakit_ekleme_view_model.dart';

import '../../components/yakit_ekleme_text_form_field.dart';
import '../../model/delet_model.dart';
import '../../utils/validator.dart';

class YakitEklemeView extends StatelessWidget with Validator {
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
              child: Padding(
            padding: context.paddingLow,
            child: Form(
              key: viewModel.formKey,
              child: Wrap(
                children: [
                  Divider(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialEntryMode: DatePickerEntryMode.calendar,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now().subtract(const Duration(days: 3000)),
                                    lastDate: DateTime.now().add(const Duration(days: 300)))
                                .then((value) => value != null ? viewModel.controllerAlisTarihi.text = value.stringValue : null);
                          },
                          decoration: InputDecoration(prefixIcon: Icon(Icons.calendar_today_outlined)),
                          controller: viewModel.controllerAlisTarihi,
                          readOnly: true,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          onTap: () {
                            showTimePicker(
                                    useRootNavigator: false,
                                    context: context,
                                    initialTime: viewModel.isNew ? TimeOfDay.now() : viewModel.yakitIslemModel.alisSaati!)
                                .then((value) => viewModel.controllerAlisSaati.text = (value?.stringValue)!);
                          },
                          decoration: const InputDecoration(prefixIcon: Icon(Icons.watch_later_outlined)),
                          controller: viewModel.controllerAlisSaati,
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Consumer<YakitEklemeViewModel>(
                    builder: (context, viewModel, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          viewModel.isNew
                              ? Text("Son Km:${viewModel.carModel.aracKm}")
                              : Text(
                                  "${viewModel.birOncekiBirSonrakiKmHesapla().birOnceki}   ${viewModel.birOncekiBirSonrakiKmHesapla().birSonraki}"),
                          YakitEklemeTextFormField(
                              validator: viewModel.isNew
                                  ? (value) => value == "" ? bosOlamaz(value!) : kucukOlamaz(value!, viewModel.carModel.aracKm!)
                                  : (value) => kmKontrol(value!, viewModel.birOncekiBirSonrakiKmHesapla().birOnceki,
                                      viewModel.birOncekiBirSonrakiKmHesapla().birSonraki),
                              icon: Icons.ac_unit_rounded,
                              text: "ARAÇ KM",
                              suffixTex: "KM",
                              controller: viewModel.controllerKm),
                        ],
                      );
                    },
                  ),
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
                    icon: Icons.ac_unit_rounded,
                    text: "Tutar",
                    suffixTex: "TL",
                    controller: viewModel.controllerToplamTutar,
                    onChanged: (value) {
                      viewModel.yakitMiktariHesapla();
                    },
                  ),
                  YakitEklemeTextFormField(
                    icon: Icons.ac_unit_rounded,
                    text: "Birim Fiyat",
                    suffixTex: "TL",
                    controller: viewModel.controllerBirimFiyat,
                    onChanged: (value) {
                      viewModel.yakitMiktariHesapla();
                    },
                  ),
                  YakitEklemeTextFormField(
                    icon: Icons.ac_unit_rounded,
                    text: "Miktar",
                    suffixTex: "L",
                    controller: viewModel.controllerMiktar,
                  ),
                  ButtonBar(alignment: MainAxisAlignment.center, children: [
                    viewModel.isNew
                        ? ElevatedButton(
                            onPressed: () {
                              if (viewModel.formKey.currentState!.validate()) {
                                Navigator.pop<YakitIslemModel>(context, viewModel.modeliHazirla());
                              }
                            },
                            child: Text("EKLE"))
                        : Row(children: [
                            Padding(
                              padding: context.paddingLow,
                              child: ElevatedButton(
                                child: const Text("Güncelle"),
                                onPressed: () {
                                  if (viewModel.formKey.currentState!.validate()) {
                                    Navigator.pop<YakitIslemModel>(
                                      context,
                                      viewModel.modeliHazirla(),
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: context.paddingLow,
                              child: ElevatedButton(
                                child: const Text("Sil"),
                                onPressed: () {
                                  Navigator.pop<YakitIslemModel>(context, viewModel.modeliHazirla());
                                },
                              ),
                            )
                          ]),
                  ])
                ],
              ),
            ),
          )),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/yakit_turu_secim_dialog.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/utils/date_time_extension.dart';

import 'package:yakit_takip_2022/view/yakit_ekleme/yakit_ekleme_view_model.dart';

import '../../components/my_app_bar.dart';
import '../../components/my_app_bar_action_button.dart';
import '../../components/my_banner_adwidget.dart';
import '../../components/yakit_ekleme_text_form_field.dart';
import '../../utils/validator.dart';

class YakitEklemeView extends StatelessWidget with Validator {
  const YakitEklemeView({Key? key, required this.viewModel}) : super(key: key);

  final YakitEklemeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
          appBar: MyAppBar(
            context: context,
            label: viewModel.isNew ? "Yakit Ekleme" : "Yakit Güncelleme",
            actions: [
              MyAppBarActionButton(onPressed: () {
                if (viewModel.formKey.currentState!.validate()) {
                  Navigator.pop<YakitIslemModel>(context, viewModel.modeliHazirla());
                }
              })
            ],
          ),
          body: _buildBody(context),
          bottomNavigationBar: const MyBannerAdWidget(size: AdSize.largeBanner),
        ));
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: context.paddingLow,
      child: Form(
        key: viewModel.formKey,
        child: Wrap(
          children: [
            const Divider(),
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
                    decoration: const InputDecoration(prefixIcon: Icon(Icons.calendar_today_outlined)),
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
                          .then((value) => value != null ? viewModel.controllerAlisSaati.text = (value.stringValue) : null);
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
                        ? Text(
                            "Son Km:${viewModel.carModel.aracKm}",
                            style: const TextStyle(color: Colors.green),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Bir Önceki Km:${viewModel.birOncekiBirSonrakiKmHesapla().birOnceki ?? "---"}",
                                style: const TextStyle(color: Colors.green),
                              ),
                              Text("Bir Sonraki KM: ${viewModel.birOncekiBirSonrakiKmHesapla().birSonraki ?? "---"}",
                                  style: const TextStyle(color: Colors.green))
                            ],
                          ),
                    YakitEklemeTextFormField(
                        validator: viewModel.isNew
                            ? (value) => value == "" ? bosOlamaz(value!) : kucukOlamaz(value!, viewModel.carModel.aracKm!)
                            : (value) => kmKontrol(
                                value!, viewModel.birOncekiBirSonrakiKmHesapla().birOnceki, viewModel.birOncekiBirSonrakiKmHesapla().birSonraki),
                        icon: Icons.add_road_rounded,
                        text: "ARAÇ KM",
                        suffixTex: "KM",
                        controller: viewModel.controllerKm,
                        keyboardType: TextInputType.number),
                  ],
                );
              },
            ),
            YakitEklemeTextFormField(
              icon: Icons.local_gas_station_outlined,
              text: "YAKIT TÜRÜ",
              controller: viewModel.controllerYakitTuru,
              readOnly: true,
              onTap: () {
                if (viewModel.carModel.yakitTuru == YakitTuruEnum.LPG) {
                  showDialog<YakitTuruEnum>(
                      context: context,
                      builder: (context) {
                        return const YakitTuruSecimDialog(isLpg: true);
                      }).then((value) {
                    if (value != null) {
                      viewModel.controllerYakitTuru.text = value.name.toUpperCase();
                    }
                  });
                }
              },
            ),
            YakitEklemeTextFormField(
              icon: Icons.money,
              text: "Tutar",
              suffixTex: "TL",
              controller: viewModel.controllerToplamTutar,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                viewModel.yakitMiktariHesapla();
              },
            ),
            YakitEklemeTextFormField(
              icon: Icons.money,
              text: "Birim Fiyat",
              suffixTex: "TL",
              controller: viewModel.controllerBirimFiyat,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                viewModel.yakitMiktariHesapla();
              },
            ),
            YakitEklemeTextFormField(
              icon: Icons.gas_meter_outlined,
              text: "Miktar",
              suffixTex: "L",
              controller: viewModel.controllerMiktar,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    ));
  }
}

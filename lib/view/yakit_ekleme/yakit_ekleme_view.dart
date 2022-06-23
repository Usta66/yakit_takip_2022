import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/yakit_turu_secim_dialog.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/navigation/navigation_route_services.dart';
import 'package:yakit_takip_2022/navigation/navigation_services.dart';
import 'package:yakit_takip_2022/utils/date_time_extension.dart';

import 'package:yakit_takip_2022/view/yakit_ekleme/yakit_ekleme_view_model.dart';

import '../../components/left_icon_text.dart';
import '../../components/my_app_bar.dart';
import '../../components/my_app_bar_action_button.dart';
import '../../components/my_banner_adwidget.dart';
import '../../components/yakit_ekleme_text_form_field.dart';
import '../../constants/app_constants.dart';
import '../../utils/locale_keys.g.dart';
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
            label: viewModel.yakitEklemeViewDurum == YakitEklemeViewDurum.yeni
                ? LocaleKeys.yakitEkleme_yakitEkleme
                : viewModel.yakitEklemeViewDurum == YakitEklemeViewDurum.guncelleme
                    ? LocaleKeys.yakitEkleme_yakitGuncelleme
                    : LocaleKeys.yakitEkleme_yakitDetay,
            actions: [
              Visibility(
                visible: viewModel.yakitEklemeViewDurum != YakitEklemeViewDurum.detay,
                child: MyAppBarActionButton(onPressed: () {
                  if (viewModel.formKey.currentState!.validate()) {
                    Navigator.pop<YakitIslemModel>(context, viewModel.modeliHazirla());
                  }
                }),
              )
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    onTap: viewModel.yakitEklemeViewDurum != YakitEklemeViewDurum.detay
                        ? () {
                            showDatePicker(
                                    context: context,
                                    initialEntryMode: DatePickerEntryMode.calendar,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now().subtract(const Duration(days: 3000)),
                                    lastDate: DateTime.now().add(const Duration(days: 300)))
                                .then((value) => value != null ? viewModel.controllerAlisTarihi.text = value.stringValue : null);
                          }
                        : null,
                    decoration: const InputDecoration(prefixIcon: Icon(Icons.calendar_today_outlined)),
                    controller: viewModel.controllerAlisTarihi,
                    readOnly: true,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    onTap: viewModel.yakitEklemeViewDurum != YakitEklemeViewDurum.detay
                        ? () {
                            showTimePicker(
                                    useRootNavigator: false,
                                    context: context,
                                    initialTime: viewModel.yakitEklemeViewDurum == YakitEklemeViewDurum.yeni
                                        ? TimeOfDay.now()
                                        : viewModel.yakitIslemModel.alisSaati!)
                                .then((value) => value != null ? viewModel.controllerAlisSaati.text = (value.stringValue) : null);
                          }
                        : null,
                    decoration: const InputDecoration(prefixIcon: Icon(Icons.watch_later_outlined)),
                    controller: viewModel.controllerAlisSaati,
                    readOnly: true,
                  ),
                ),
              ],
            ),
            Consumer<YakitEklemeViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    viewModel.yakitEklemeViewDurum == YakitEklemeViewDurum.yeni
                        ? Text(
                            LocaleKeys.yakitEkleme_aracKm.tr() + viewModel.carModel.aracKm.toString(),
                            style: const TextStyle(color: Colors.green),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                LocaleKeys.yakitEkleme_birOncekiKm.tr() +
                                    (viewModel.birOncekiBirSonrakiKmHesapla().birOnceki != null
                                        ? viewModel.birOncekiBirSonrakiKmHesapla().birOnceki.toString()
                                        : "---"),
                                style: const TextStyle(color: Colors.green),
                              ),
                              Text(
                                  LocaleKeys.yakitEkleme_birSonrakiKm.tr() +
                                      (viewModel.birOncekiBirSonrakiKmHesapla().birSonraki != null
                                          ? viewModel.birOncekiBirSonrakiKmHesapla().birSonraki.toString()
                                          : "---"),
                                  style: const TextStyle(color: Colors.green))
                            ],
                          ),
                    YakitEklemeTextFormField(
                        readOnly: viewModel.yakitEklemeViewDurum == YakitEklemeViewDurum.detay,
                        validator: viewModel.yakitEklemeViewDurum == YakitEklemeViewDurum.yeni
                            ? (value) => value == "" ? bosOlamaz(value!) : kucukOlamaz(value!, viewModel.carModel.aracKm!)
                            : (value) => kmKontrol(
                                value!, viewModel.birOncekiBirSonrakiKmHesapla().birOnceki, viewModel.birOncekiBirSonrakiKmHesapla().birSonraki),
                        icon: Icons.add_road_rounded,
                        text: LocaleKeys.yakitEkleme_aracKm,
                        suffixTex: StringConstants.km,
                        controller: viewModel.controllerKm,
                        keyboardType: TextInputType.number),
                  ],
                );
              },
            ),
            YakitEklemeTextFormField(
              icon: Icons.local_gas_station_outlined,
              text: LocaleKeys.add_new_car_yakitTuru,
              controller: viewModel.controllerYakitTuru,
              readOnly: true,
              onTap: viewModel.yakitEklemeViewDurum != YakitEklemeViewDurum.detay
                  ? () {
                      if (viewModel.carModel.yakitTuru == YakitTuruEnum.LPG) {
                        showDialog<YakitTuruEnum>(
                            context: context,
                            builder: (context) {
                              return const YakitTuruSecimDialog(isLpg: true);
                            }).then((value) {
                          if (value != null) {
                            viewModel.controllerYakitTuru.text = value.name.tr().toUpperCase();
                          }
                        });
                      }
                    }
                  : null,
            ),
            YakitEklemeTextFormField(
              readOnly: viewModel.yakitEklemeViewDurum == YakitEklemeViewDurum.detay,
              icon: Icons.money,
              text: LocaleKeys.yakitList_tutar,
              suffixTex: StringConstants.tl,
              controller: viewModel.controllerToplamTutar,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                viewModel.yakitMiktariHesapla();
              },
            ),
            YakitEklemeTextFormField(
              readOnly: viewModel.yakitEklemeViewDurum == YakitEklemeViewDurum.detay,
              icon: Icons.money,
              text: LocaleKeys.yakitEkleme_birimFiyat,
              suffixTex: StringConstants.tl,
              controller: viewModel.controllerBirimFiyat,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                viewModel.yakitMiktariHesapla();
              },
            ),
            YakitEklemeTextFormField(
              readOnly: viewModel.yakitEklemeViewDurum == YakitEklemeViewDurum.detay,
              icon: Icons.gas_meter_outlined,
              text: LocaleKeys.miktar,
              suffixTex: StringConstants.l,
              controller: viewModel.controllerMiktar,
              keyboardType: TextInputType.number,
            ),
            Visibility(
              visible: viewModel.yakitEklemeViewDurum != YakitEklemeViewDurum.detay,
              child: Padding(
                padding: context.paddingLow,
                child: LeftIconText(text: LocaleKeys.yakitEkleme_belgeYukle.tr(), icon: Icons.file_present_outlined),
              ),
            ),
            Consumer<YakitEklemeViewModel>(
              builder: (context, value, child) {
                return Padding(
                  padding: context.paddingNormal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (viewModel.image != null) {
                            goToViewPush(path: NavigationEnum.fullscreenImage, args: viewModel.image);
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                              size: const Size.fromRadius(48),
                              child: viewModel.image != null
                                  ? Image.file(
                                      viewModel.image!,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(AssetsConstants.instance!.NO_IMAGE)),
                        ),
                      ),
                      Visibility(
                        visible: viewModel.yakitEklemeViewDurum != YakitEklemeViewDurum.detay,
                        child: ButtonBar(children: [
                          IconButton(onPressed: () => viewModel.getImage(false), icon: const Icon(Icons.camera_alt_outlined)),
                          IconButton(onPressed: () => viewModel.getImage(true), icon: const Icon(Icons.file_upload_rounded)),
                          IconButton(onPressed: () => viewModel.deletImage(), icon: const Icon(Icons.delete_forever_outlined))
                        ]),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    ));
  }
}

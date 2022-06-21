import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';

import 'package:yakit_takip_2022/navigation/navigation_services.dart';
import 'package:yakit_takip_2022/utils/locale_keys.g.dart';

import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';
import 'package:yakit_takip_2022/view/yakit_ekleme/yakit_ekleme_view_model.dart';

import '../../../components/circle_avatar_image_and_alphabet.dart';

import '../../../components/locale_text.dart';
import '../../../components/my_app_bar.dart';
import '../../../constants/app_constants.dart';
import '../../../navigation/navigation_route_services.dart';
import '../../../utils/date_time_extension.dart';

class YakitListView extends StatelessWidget {
  const YakitListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        label: LocaleKeys.yakitList_yakitListesi,
      ),
      body: _buildBody(),
    );
  }

  Consumer<HomeAndYakitListViewModel> _buildBody() {
    return Consumer<HomeAndYakitListViewModel>(
        builder: (context, viewModel, child) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.listYakitIslemModel.length,
        itemBuilder: (context, index) {
          YakitIslemModel yakitIslemModel =
              viewModel.listYakitIslemModel[index]!;
          return Padding(
              padding: context.paddingNormal,
              child: Card(
                child: Slidable(
                  endActionPane: ActionPane(
                      extentRatio: 0.50,
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.blueAccent,
                          label: LocaleKeys.guncelle.tr(),
                          onPressed: (context) {
                            goToViewPush<YakitIslemModel>(
                                path: NavigationEnum.yakitGuncelleme,
                                args: YakitEklemeViewModel.show(
                                    yakitIslemModel:
                                        viewModel.listYakitIslemModel[index]!,
                                    carModel: viewModel.carModel,
                                    yakitHesapModel: viewModel.yakitHesapModel,
                                    index: index),
                                function: (gelenModel) {
                                  viewModel.modelUpdate(gelenModel);
                                });
                          },
                          icon: Icons.update_rounded,
                        ),
                        SlidableAction(
                            backgroundColor: Colors.redAccent,
                            label: LocaleKeys.sil.tr(),
                            onPressed: (context) {
                              viewModel.delete(
                                  viewModel.listYakitIslemModel[index]!);
                            },
                            icon: Icons.delete)
                      ]),
                  child: Padding(
                    padding: context.paddingNormal,
                    child: GestureDetector(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CircleAvatarImageAndAlphabet(
                              color:
                                  yakitIslemModel.yakitTuru == YakitTuruEnum.LPG
                                      ? 0x4D05FF3B
                                      : 0x989F0D7D,
                              radius: context.width * 0.15,
                              text: yakitIslemModel.yakitTuru != null
                                  ? yakitIslemModel.yakitTuru!.name
                                      .toUpperCase()
                                      .tr()
                                  : null),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: context.normalValue),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          LocaleText(LocaleKeys.yakitList_tarih,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1),
                                          Text(
                                              yakitIslemModel
                                                  .alisTarihi!.stringValue,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: context.lowValue),
                                            child: LocaleText(
                                                StringConstants.km,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                          ),
                                          Text(
                                              yakitIslemModel.aracKm
                                                      .toString() +
                                                  StringConstants.km,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          LocaleText(LocaleKeys.miktar,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1),
                                          Text(
                                              yakitIslemModel.miktari
                                                      .toString() +
                                                  StringConstants.l,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: context.lowValue),
                                            child: LocaleText(
                                                LocaleKeys.yakitList_tutar,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                          ),
                                          Text(
                                              yakitIslemModel.tutar.toString() +
                                                  StringConstants.tl,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(StringConstants.tlKm,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1),
                                          yakitIslemModel.tutar != null &&
                                                  yakitIslemModel.mesafe != null
                                              ? Text(
                                                  (yakitIslemModel.tutar! /
                                                              yakitIslemModel
                                                                  .mesafe!)
                                                          .toStringAsFixed(2) +
                                                      StringConstants.tl,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2)
                                              : Text("---",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: context.lowValue),
                                            child: Text(StringConstants.lKm,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                          ),
                                          yakitIslemModel.miktari != null &&
                                                  yakitIslemModel.mesafe != null
                                              ? Text(
                                                  (yakitIslemModel.miktari! /
                                                              yakitIslemModel
                                                                  .mesafe!)
                                                          .toStringAsFixed(2) +
                                                      StringConstants.l,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2)
                                              : Text("---",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(LocaleKeys.fiyat.tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1),
                                          Text(
                                              yakitIslemModel.fiyati
                                                      .toString() +
                                                  StringConstants.tl,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: context.lowValue),
                                            child: Text(
                                                LocaleKeys.yakitList_mesafe
                                                    .tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                          ),
                                          Text(
                                              "${yakitIslemModel.mesafe ?? "---"} ${StringConstants.km}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2)
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
                ),
              ));

          // ignore: dead_code
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Slidable(
                endActionPane: ActionPane(
                    extentRatio: 0.50,
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.blueAccent,
                        label: LocaleKeys.guncelle.tr(),
                        onPressed: (context) {
                          goToViewPush<YakitIslemModel>(
                              path: NavigationEnum.yakitGuncelleme,
                              args: YakitEklemeViewModel.show(
                                  yakitIslemModel:
                                      viewModel.listYakitIslemModel[index]!,
                                  carModel: viewModel.carModel,
                                  yakitHesapModel: viewModel.yakitHesapModel,
                                  index: index),
                              function: (gelenModel) {
                                viewModel.modelUpdate(gelenModel);
                              });
                        },
                        icon: Icons.update_rounded,
                      ),
                      SlidableAction(
                          backgroundColor: Colors.redAccent,
                          label: LocaleKeys.sil.tr(),
                          onPressed: (context) {
                            viewModel
                                .delete(viewModel.listYakitIslemModel[index]!);
                          },
                          icon: Icons.delete)
                    ]),
                child: Padding(
                  padding: context.paddingLow,
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Expanded(
                          child: CircleAvatarImageAndAlphabet(
                              color:
                                  yakitIslemModel.yakitTuru == YakitTuruEnum.LPG
                                      ? 0x4D05FF3B
                                      : 0x989F0D7D,
                              radius: context.width * 0.05,
                              text: yakitIslemModel.yakitTuru != null
                                  ? yakitIslemModel.yakitTuru!.name[0]
                                  : null),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(LocaleKeys.yakitList_tarih.tr(),
                                  style: Theme.of(context).textTheme.subtitle1),
                              Text(yakitIslemModel.alisTarihi!.stringValue,
                                  style: Theme.of(context).textTheme.subtitle2),
                              Padding(
                                padding: EdgeInsets.only(top: context.lowValue),
                                child: Text(StringConstants.km,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                              Text(
                                  "${yakitIslemModel.aracKm} ${StringConstants.km}",
                                  style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(LocaleKeys.miktar.tr(),
                                  style: Theme.of(context).textTheme.subtitle1),
                              Text(
                                  "${yakitIslemModel.miktari} ${StringConstants.l}",
                                  style: Theme.of(context).textTheme.subtitle2),
                              Padding(
                                padding: EdgeInsets.only(top: context.lowValue),
                                child: Text(LocaleKeys.yakitList_tutar.tr(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                              Text(
                                  "${yakitIslemModel.tutar} ${StringConstants.tl}",
                                  style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(StringConstants.tlKm,
                                  style: Theme.of(context).textTheme.subtitle1),
                              yakitIslemModel.tutar != null &&
                                      yakitIslemModel.mesafe != null
                                  ? Text(
                                      "${(yakitIslemModel.tutar! / yakitIslemModel.mesafe!).toStringAsFixed(2)} ${StringConstants.tl}",
                                      style:
                                          Theme.of(context).textTheme.subtitle2)
                                  : Text("---",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                              Padding(
                                padding: EdgeInsets.only(top: context.lowValue),
                                child: Text(StringConstants.lKm,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                              yakitIslemModel.miktari != null &&
                                      yakitIslemModel.mesafe != null
                                  ? Text(
                                      "${(yakitIslemModel.miktari! / yakitIslemModel.mesafe!).toStringAsFixed(2)} ${StringConstants.l}",
                                      style:
                                          Theme.of(context).textTheme.subtitle2)
                                  : Text("---",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(LocaleKeys.fiyat.tr(),
                                  style: Theme.of(context).textTheme.subtitle1),
                              Text(
                                  "${yakitIslemModel.fiyati} ${StringConstants.tl} ",
                                  style: Theme.of(context).textTheme.subtitle2),
                              Padding(
                                padding: EdgeInsets.only(top: context.lowValue),
                                child: Text(LocaleKeys.yakitList_mesafe.tr(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                              Text(
                                  "${yakitIslemModel.mesafe ?? "---"} ${StringConstants.km}",
                                  style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

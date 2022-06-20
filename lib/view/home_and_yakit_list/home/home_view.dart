import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kartal/kartal.dart';

import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/components/my_chart.dart';

import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';

import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/utils/date_time_extension.dart';
import 'package:yakit_takip_2022/utils/extantion.dart';
import 'package:yakit_takip_2022/utils/locale_keys.g.dart';

import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';

import '../../../components/locale_text.dart';
import '../../../components/my_app_bar.dart';
import '../../../components/my_banner_adwidget.dart';
import '../../../services/admob_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AdmobService.instance!.getIsInterstitialAdReady) {
      AdmobService.instance!.getInterstitialAd.show();
    }
    return WillPopScope(
      onWillPop: () {
        AdmobService.instance!.bannerAd.dispose();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: MyAppBar(context: context, label: LocaleKeys.home_aracDetay),
        body: SingleChildScrollView(child: Consumer<HomeAndYakitListViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                aracKmVerileriCard(context, viewModel),
                lpgVerileriCard(viewModel, context),
                akaryakitVerileriColumn(context, viewModel)
              ],
            );
          },
        )),
      ),
    );
  }

  Widget aracKmVerileriCard(
      BuildContext context, HomeAndYakitListViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.normalValue),
      child: Card(
        child: Column(
          children: [
            Container(
              color: Colors.amberAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LocaleText(LocaleKeys.home_aracKmVerileri,
                      style: Theme.of(context).textTheme.headline5),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: context.paddingNormal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocaleText(
                        LocaleKeys.home_yakitAlinanSonKm,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      LocaleText(
                        LocaleKeys.home_toplamKm,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.yakitHesapModel.sonKm + LocaleKeys.km.tr(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      viewModel.yakitHesapModel.toplamKm + LocaleKeys.km.tr(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Visibility lpgVerileriCard(
      HomeAndYakitListViewModel viewModel, BuildContext context) {
    return Visibility(
        visible: viewModel.carModel.yakitTuru == YakitTuruEnum.LPG,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: context.normalValue),
              child: Card(
                child: Column(
                  children: [
                    Container(
                      color: Colors.amberAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocaleText(LocaleKeys.home_karmaYakitVerileri,
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                    ),
                    Padding(
                      padding: context.paddingNormal,
                      child: Row(children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LocaleText(LocaleKeys.home_tuketim,
                                  style: Theme.of(context).textTheme.headline5),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  viewModel.yakitHesapModel.tLKm +
                                      LocaleKeys.tlKM.tr(),
                                  style: Theme.of(context).textTheme.headline5),
                            ],
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Column(
                children: [
                  Container(
                    color: Colors.amberAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LocaleText(LocaleKeys.home_lpgVerileri,
                            style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                  ),
                  Padding(
                    padding: context.paddingNormal,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LocaleText(
                              LocaleKeys.home_yakitAlinanIlkTarih,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            LocaleText(
                              LocaleKeys.home_tuketim,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            LocaleText(
                              LocaleKeys.home_tuketim,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            LocaleText(
                              LocaleKeys.home_ortalamaLpgFiyati,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            LocaleText(
                              LocaleKeys.home_toplamYakitAlimSayisi,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            LocaleText(
                              LocaleKeys.home_taplamMaliyet,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            LocaleText(
                              LocaleKeys.home_toplamMiktar,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (viewModel.yakitHesapModel.listYakitIslemModelLpg
                                      .isNotNullOrEmpty
                                  ? viewModel
                                      .yakitHesapModel
                                      .listYakitIslemModelLpg
                                      .first!
                                      .alisTarihi!
                                      .stringValue
                                  : "---"),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel.yakitHesapModel.tLKmLpg +
                                  LocaleKeys.tlKM.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel.yakitHesapModel.litreKmLpg +
                                  LocaleKeys.l100Km.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel.yakitHesapModel.ortalamaLpgMaliyeti,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel
                                  .yakitHesapModel.listYakitIslemModelLpg.length
                                  .toString(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel.yakitHesapModel.toplamLpgMaliyeti +
                                  LocaleKeys.tl.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel.yakitHesapModel.toplamLpgMiktari +
                                  LocaleKeys.l.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const MyBannerAdWidget(size: AdSize.largeBanner),
            MyChart(
                chartTitle: LocaleKeys.home_fiyatMiktarLpg.tr(),
                dataSource: viewModel.yakitHesapModel.listYakitIslemModelLpg,
                yValueMapper: (YakitIslemModel? sales, _) => sales!.fiyati,
                yValueMapper2: (YakitIslemModel? sales, _) => sales!.miktari!,
                name: LocaleKeys.fiyat.tr() + LocaleKeys.tl.tr(),
                name2: LocaleKeys.miktar.tr() + LocaleKeys.l.tr()),
            MyChart(
                chartTitle: LocaleKeys.home_tlkmlkmLpg.tr(),
                name: LocaleKeys.tlKM.tr(),
                name2: LocaleKeys.l100Km.tr(),
                dataSource: viewModel.yakitHesapModel.listYakitIslemModelLpg,
                yValueMapper: (sales, _) =>
                    sales!.tutar != null && sales.mesafe != null
                        ? (sales.tutar! / sales.mesafe!).asFixed(2)
                        : null,
                yValueMapper2: (sales, _) =>
                    sales!.miktari != null && sales.mesafe != null
                        ? (sales.miktari! / sales.mesafe! * 100).asFixed(2)
                        : null),
          ],
        ));
  }

  akaryakitVerileriColumn(
      BuildContext context, HomeAndYakitListViewModel viewModel) {
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              Container(
                color: Colors.amberAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LocaleText(LocaleKeys.home_akaryakitVerileri,
                        style: Theme.of(context).textTheme.headline5),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: context.paddingNormal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LocaleText(
                          LocaleKeys.home_yakitAlinanIlkTarih,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        LocaleText(LocaleKeys.home_tuketim,
                            style: Theme.of(context).textTheme.subtitle1),
                        LocaleText(LocaleKeys.home_tuketim,
                            style: Theme.of(context).textTheme.subtitle1),
                        LocaleText(
                          LocaleKeys.home_ortalamaAkaryakitFiyati,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        LocaleText(
                          LocaleKeys.home_toplamYakitAlimSayisi,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        LocaleText(
                          LocaleKeys.home_taplamMaliyet,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        LocaleText(LocaleKeys.home_toplamMiktar,
                            style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.yakitHesapModel.listYakitIslemModelAkaryakit
                                .isNotNullOrEmpty
                            ? viewModel
                                .yakitHesapModel
                                .listYakitIslemModelAkaryakit
                                .first!
                                .alisTarihi!
                                .stringValue
                            : "---",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(LocaleKeys.tlKM.tr(),
                          style: Theme.of(context).textTheme.subtitle1),
                      Text(LocaleKeys.l100Km.tr(),
                          style: Theme.of(context).textTheme.subtitle1),
                      Text(
                        viewModel.yakitHesapModel.ortalamaAkaryakitMaliyeti,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        viewModel
                            .yakitHesapModel.listYakitIslemModelAkaryakit.length
                            .toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        viewModel.yakitHesapModel.toplamAkaryakitMaliyeti +
                            LocaleKeys.tl.tr(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                          viewModel.yakitHesapModel.toplamAkaryakitMiktari +
                              LocaleKeys.l.tr(),
                          style: Theme.of(context).textTheme.subtitle1),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        const MyBannerAdWidget(size: AdSize.largeBanner),
        MyChart(
            chartTitle: LocaleKeys.home_fiyatMiktarAkaryakit.tr(),
            name: LocaleKeys.fiyat.tr() + LocaleKeys.tl.tr(),
            name2: LocaleKeys.miktar.tr() + LocaleKeys.l.tr(),
            dataSource: viewModel.yakitHesapModel.listYakitIslemModelAkaryakit,
            yValueMapper: (sales, _) => sales!.fiyati,
            yValueMapper2: (sales, _) => sales!.miktari!),
        Padding(
          padding: EdgeInsets.only(bottom: context.normalValue),
          child: MyChart(
            chartTitle: LocaleKeys.home_tlkmlkmAkaryakit.tr(),
            name: LocaleKeys.tlKM.tr(),
            name2: LocaleKeys.tlKM.tr(),
            dataSource: viewModel.yakitHesapModel.listYakitIslemModelAkaryakit,
            yValueMapper: (sales, _) =>
                sales!.tutar != null && sales.mesafe != null
                    ? (sales.tutar! / sales.mesafe!)
                    : null,
            yValueMapper2: (sales, _) =>
                sales!.miktari != null && sales.mesafe != null
                    ? sales.miktari! / sales.mesafe! * 100
                    : null,
          ),
        )
      ],
    );
  }
}

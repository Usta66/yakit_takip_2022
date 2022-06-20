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
import '../../../components/aciklama_card.dart';
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
              children: [aracKmVerileriCard(context, viewModel), lpgVerileriCard(viewModel, context), akaryakitVerileriColumn(context, viewModel)],
            );
          },
        )),
      ),
    );
  }

  Widget aracKmVerileriCard(BuildContext context, HomeAndYakitListViewModel viewModel) {
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
                  LocaleText(LocaleKeys.home_aracKmVerileri, style: Theme.of(context).textTheme.headline5),
                ],
              ),
            ),
            Text(
              LocaleKeys.home_yakitAlinanSonKm.tr() + viewModel.yakitHesapModel.sonKm + LocaleKeys.km.tr(),
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              LocaleKeys.home_toplamKm.tr() + viewModel.yakitHesapModel.toplamKm + LocaleKeys.km.tr(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }

  Visibility lpgVerileriCard(HomeAndYakitListViewModel viewModel, BuildContext context) {
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
                          LocaleText(LocaleKeys.home_karmaYakitVerileri, style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(viewModel.yakitHesapModel.tLKm, style: Theme.of(context).textTheme.headline5),
                      LocaleText(LocaleKeys.tlKM, style: Theme.of(context).textTheme.headline5),
                    ])
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
                        LocaleText(LocaleKeys.home_lpgVerileri, style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: context.normalValue),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.home_yakitAlinanIlkTarih.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Tüketim: ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Tüketim: ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              LocaleKeys.home_ortalamaLpgFiyati.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              LocaleKeys.home_toplamYakitAlimSayisi.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              LocaleKeys.home_taplamMaliyet.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              LocaleKeys.home_toplamMiktar.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (viewModel.yakitHesapModel.listYakitIslemModelLpg.isNotNullOrEmpty
                                  ? viewModel.yakitHesapModel.listYakitIslemModelLpg.first!.alisTarihi!.stringValue
                                  : "---"),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel.yakitHesapModel.tLKmLpg + LocaleKeys.tlKM.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel.yakitHesapModel.litreKmLpg + LocaleKeys.l100Km.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel.yakitHesapModel.ortalamaLpgMaliyeti,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel.yakitHesapModel.listYakitIslemModelLpg.length.toString(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel.yakitHesapModel.toplamLpgMaliyeti + LocaleKeys.tl.tr(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              viewModel.yakitHesapModel.toplamLpgMiktari + LocaleKeys.l.tr(),
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
            // AciklamaCard(yakitHesapModel: viewModel.yakitHesapModel, isLPG: true),
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
                yValueMapper: (sales, _) => sales!.tutar != null && sales.mesafe != null ? (sales.tutar! / sales.mesafe!).asFixed(2) : null,
                yValueMapper2: (sales, _) =>
                    sales!.miktari != null && sales.mesafe != null ? (sales.miktari! / sales.mesafe! * 100).asFixed(2) : null),
          ],
        ));
  }

  akaryakitVerileriColumn(BuildContext context, HomeAndYakitListViewModel viewModel) {
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              const Divider(),
              Container(
                color: Colors.amberAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LocaleText(LocaleKeys.home_akaryakitVerileri, style: Theme.of(context).textTheme.headline5),
                  ],
                ),
              ),
              Text(
                LocaleKeys.home_yakitAlinanIlkTarih.tr() +
                    (viewModel.yakitHesapModel.listYakitIslemModelAkaryakit.isNotNullOrEmpty
                        ? viewModel.yakitHesapModel.listYakitIslemModelAkaryakit.first!.alisTarihi!.stringValue
                        : "---"),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(viewModel.yakitHesapModel.tlKmAkaryakit.tr() + LocaleKeys.tlKM.tr(), style: Theme.of(context).textTheme.subtitle1),
              Text(viewModel.yakitHesapModel.litreKmAkaryakit.tr() + LocaleKeys.l100Km.tr(), style: Theme.of(context).textTheme.subtitle1),
              Text(
                LocaleKeys.home_ortalamaAkaryakitFiyati.tr() + viewModel.yakitHesapModel.ortalamaAkaryakitMaliyeti,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                LocaleKeys.home_toplamYakitAlimSayisi.tr() + viewModel.yakitHesapModel.listYakitIslemModelAkaryakit.length.toString(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                LocaleKeys.home_taplamMaliyet.tr() + viewModel.yakitHesapModel.toplamAkaryakitMaliyeti + LocaleKeys.tl.tr(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(LocaleKeys.home_toplamMiktar.tr() + viewModel.yakitHesapModel.toplamAkaryakitMiktari + LocaleKeys.l.tr(),
                  style: Theme.of(context).textTheme.subtitle1)
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
            yValueMapper: (sales, _) => sales!.tutar != null && sales.mesafe != null ? (sales.tutar! / sales.mesafe!) : null,
            yValueMapper2: (sales, _) => sales!.miktari != null && sales.mesafe != null ? sales.miktari! / sales.mesafe! * 100 : null,
          ),
        )
      ],
    );
  }
}

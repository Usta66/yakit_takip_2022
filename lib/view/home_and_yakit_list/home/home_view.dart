import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kartal/kartal.dart';

import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/components/my_chart.dart';

import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';

import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/utils/extantion.dart';

import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';
import '../../../components/aciklama_card.dart';
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
        appBar: MyAppBar(context: context, label: "Araç Detay"),
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

  Card aracKmVerileriCard(
      BuildContext context, HomeAndYakitListViewModel viewModel) {
    return Card(
      child: Column(
        children: [
          Container(
            color: Colors.amberAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Araç KM Verileri",
                    style: Theme.of(context).textTheme.headline5),
              ],
            ),
          ),
          Text(
            "Yakıt Alınan Son KM = ${viewModel.yakitHesapModel.sonKm} KM",
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            "Toplam KM= ${viewModel.yakitHesapModel.toplamKm} KM",
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  Visibility lpgVerileriCard(
      HomeAndYakitListViewModel viewModel, BuildContext context) {
    return Visibility(
        visible: viewModel.carModel.yakitTuru == YakitTuruEnum.LPG,
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Container(
                    color: Colors.amberAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Karma Yakıt Verileri",
                            style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(viewModel.yakitHesapModel.tLKm,
                        style: Theme.of(context).textTheme.headline5),
                    Text("TL/KM", style: Theme.of(context).textTheme.headline5),
                  ])
                ],
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
                        Text("LPG Verileri",
                            style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                  ),
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${viewModel.yakitHesapModel.tLKmLpg} TL/KM",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            "${viewModel.yakitHesapModel.litreKmLpg} L/100KM",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Toplam Maliyet = ${viewModel.yakitHesapModel.toplamLpgMaliyeti} TL",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            "Toplam Miktar   = ${viewModel.yakitHesapModel.toplamLpgMiktari} L ",
                            style: Theme.of(context).textTheme.subtitle1,
                          )
                        ],
                      ),
                    )
                  ]),
                ],
              ),
            ),
            AciklamaCard(
                yakitHesapModel: viewModel.yakitHesapModel, isLPG: true),
            const MyBannerAdWidget(size: AdSize.largeBanner),
            MyChart(
                chartTitle: "Fiyat-Miktar(LPG)",
                dataSource: viewModel.yakitHesapModel.listYakitIslemModelLpg,
                yValueMapper: (YakitIslemModel? sales, _) => sales!.fiyati,
                yValueMapper2: (YakitIslemModel? sales, _) => sales!.miktari!,
                name: "Fiyat TL",
                name2: "Miktar L"),
            MyChart(
                chartTitle: "TL/Km - L/100Km(LPG)",
                name: "TL/KM",
                name2: "L/100KM",
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

  Column akaryakitVerileriColumn(
      BuildContext context, HomeAndYakitListViewModel viewModel) {
    return Column(
      children: [
        const Divider(),
        Container(
          color: Colors.amberAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Akaryakıt Verileri",
                  style: Theme.of(context).textTheme.headline5),
            ],
          ),
        ),
        const Divider(),
        Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${viewModel.yakitHesapModel.tlKmAkaryakit} TL/KM",
                        style: Theme.of(context).textTheme.subtitle1),
                    Text(
                        "${viewModel.yakitHesapModel.litreKmAkaryakit} L/100KM",
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Toplam Maliyet = ${viewModel.yakitHesapModel.toplamAkaryakitMaliyeti} TL ",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                        "Toplam Miktar   = ${viewModel.yakitHesapModel.toplamAkaryakitMiktari} L ",
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                ),
              )
            ],
          ),
        )),
        AciklamaCard(
          yakitHesapModel: viewModel.yakitHesapModel,
          isLPG: false,
        ),
        const MyBannerAdWidget(size: AdSize.largeBanner),
        MyChart(
            chartTitle: "Fiyat - Miktar(Akaryakıt)",
            name: "Fiyat TL",
            name2: "Miktar L",
            dataSource: viewModel.yakitHesapModel.listYakitIslemModelAkaryakit,
            yValueMapper: (sales, _) => sales!.fiyati,
            yValueMapper2: (sales, _) => sales!.miktari!),
        Padding(
          padding: EdgeInsets.only(bottom: context.normalValue),
          child: MyChart(
            chartTitle: "TL/Km - L/100Km\n(Akaryakıt)",
            name: "TL/KM",
            name2: "L/100KM",
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
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'package:provider/provider.dart';

import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/utils/date_time_extension.dart';

import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';
import '../../../utils/date_time_extension.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Ekran"),
      ),
      body: SingleChildScrollView(child: Consumer<HomeAndYakitListViewModel>(
        builder: (context, viewModel, child) {
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
              ),
              Visibility(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                ],
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(viewModel.yakitHesapModel.tLKm,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  Text("TL/KM",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
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
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      "${viewModel.yakitHesapModel.litreKmLpg} L/100KM",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
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
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      "Toplam Miktar   = ${viewModel.yakitHesapModel.toplamLpgMiktari} L ",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ],
                        ),
                      ),
                      Card(
                        child: viewModel.yakitHesapModel.listYakitIslemModelLpg
                                .isNotNullOrEmpty
                            ? Padding(
                                padding: context.paddingLow,
                                child: Text(
                                  "${viewModel.yakitHesapModel.listYakitIslemModelLpg.first!.alisTarihi!.stringValue} tarihinden itibaren tolpam ${viewModel.yakitHesapModel.listYakitIslemModelLpg.length} kez LPG alınmış olup ortalam LPG fiyatı ${viewModel.yakitHesapModel.ortalamaLpgMaliyeti} TL'dir.",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              )
                            : Text(""),
                      ),
                      Padding(
                        padding: context.paddingLow,
                        child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            // Chart title

                            // Enable legend
                            legend: Legend(
                                isVisible: true,
                                position: LegendPosition.bottom),

                            // Enable tooltip
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries<YakitIslemModel?, String>>[
                              LineSeries<YakitIslemModel?, String>(
                                  dataSource: viewModel
                                      .yakitHesapModel.listYakitIslemModelLpg,
                                  xValueMapper: (YakitIslemModel? sales, _) =>
                                      sales!.alisTarihi!.stringValue,
                                  yValueMapper: (YakitIslemModel? sales, _) =>
                                      sales!.fiyati,
                                  name: "Fiyat TL",

                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<YakitIslemModel?, String>(
                                  dataSource: viewModel
                                      .yakitHesapModel.listYakitIslemModelLpg,
                                  xValueMapper: (YakitIslemModel? sales, _) =>
                                      sales!.alisTarihi!.stringValue,
                                  yValueMapper: (YakitIslemModel? sales, _) =>
                                      sales!.miktari!,
                                  name: 'Miktar L',
                                  // Enable data label
                                  dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                  ))
                            ]),
                      )
                    ],
                  )),
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
              Divider(),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${viewModel.yakitHesapModel.tlKmAkaryakit} TL/KM",
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
              Card(
                child: viewModel.yakitHesapModel.listYakitIslemModelAkaryakit
                        .isNotNullOrEmpty
                    ? Padding(
                        padding: context.paddingLow,
                        child: Text(
                          "${viewModel.yakitHesapModel.listYakitIslemModelAkaryakit.first!.alisTarihi!.stringValue} tarihinden itibaren tolpam ${viewModel.yakitHesapModel.listYakitIslemModelAkaryakit.length} kez Akaryakıt alınmış olup ortalam Akaryakıt fiyatı ${viewModel.yakitHesapModel.ortalamaAkaryakitMaliyeti} TL'dir.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    : Text(""),
              ),
              Padding(
                padding: context.paddingLow,
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                    ),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<YakitIslemModel?, String>>[
                      LineSeries<YakitIslemModel?, String>(
                          dataSource: viewModel
                              .yakitHesapModel.listYakitIslemModelAkaryakit,
                          xValueMapper: (YakitIslemModel? sales, _) =>
                              sales!.alisTarihi!.stringValue,
                          yValueMapper: (YakitIslemModel? sales, _) =>
                              sales!.fiyati,
                          name: "Fiyat",

                          // Enable data label
                          dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                      LineSeries<YakitIslemModel?, String>(
                          dataSource: viewModel
                              .yakitHesapModel.listYakitIslemModelAkaryakit,
                          xValueMapper: (YakitIslemModel? sales, _) =>
                              sales!.alisTarihi!.stringValue,
                          yValueMapper: (YakitIslemModel? sales, _) =>
                              sales!.miktari!,
                          name: 'Miktar',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ]),
              )
            ],
          );
        },
      )),
    );
  }
}

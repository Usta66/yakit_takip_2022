import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/components/base_text_field.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';

import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(child: Consumer<HomeAndYakitListViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              SizedBox(height: 15),
              Card(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text(
                        "Yakıt Alınan Son Km = ${viewModel.yakitHesapModel.sonKm} KM")
                  ])),
              Visibility(
                  visible: viewModel.carModel.yakitTuru == YakitTuruEnum.LPG,
                  child: Column(
                    children: [
                      Divider(),
                      Text("Karma Yakıt Verileri"),
                      Divider(),
                      Card(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(viewModel.yakitHesapModel.tLKm,
                                  style: Theme.of(context).textTheme.headline5),
                              Text("TL/KM",
                                  style: Theme.of(context).textTheme.headline5),
                            ]),
                      ),
                      const Divider(),
                      const Text("LPG Verileri"),
                      const Divider(),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${viewModel.yakitHesapModel.tLKmLpg} TL/KM"),
                                  Text(
                                      "${viewModel.yakitHesapModel.litreKmLpg} L/100KM")
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Toplam Maliyet = ${viewModel.yakitHesapModel.toplamLpgMaliyeti} TL"),
                                  Text(
                                      "Toplam Miktar   = ${viewModel.yakitHesapModel.toplamLpgMiktari} L ")
                                ],
                              ),
                            )
                          ]),
                        ),
                      )
                    ],
                  )),
              const Divider(),
              const Text(
                "Akaryakıt Verileri",
                textAlign: TextAlign.center,
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
                              "${viewModel.yakitHesapModel.tlKmAkaryakit} TL/KM"),
                          Text(
                              "${viewModel.yakitHesapModel.litreKmAkaryakit} L/100KM")
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Toplam Maliyet = ${viewModel.yakitHesapModel.toplamAkaryakitMaliyeti} TL ",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                              "Toplam Miktar   = ${viewModel.yakitHesapModel.toplamAkaryakitMiktari} L ")
                        ],
                      ),
                    )
                  ],
                ),
              )),
            ],
          );
        },
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/components/base_text_field.dart';

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
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(viewModel.yakitHesapModel.tLKm.toString(), style: Theme.of(context).textTheme.headline5),
                  Text("TL/KM", style: Theme.of(context).textTheme.headline5),
                ]),
              ),
              const Divider(),
              const Text(
                "Akaryakıt Verileri",
                textAlign: TextAlign.center,
              ),
              Card(
                  child: Row(
                children: [
                  Column(
                    children: [
                      Text("${viewModel.yakitHesapModel.tlKmAkaryakit.toString()} TL/KM"),
                      Text("${viewModel.yakitHesapModel.litreKmAkaryakit} L/100KM")
                    ],
                  ),
                  Column(
                    children: [
                      Text("${viewModel.yakitHesapModel.toplamAkaryakitMaliyeti.toString()} TL Toplam Maliyet"),
                      Text("${viewModel.yakitHesapModel.toplamAkaryakitMiktari.toString()} L Toplam Miktar")
                    ],
                  )
                ],
              ))
            ],
          );
        },
      )),
    );
  }
}

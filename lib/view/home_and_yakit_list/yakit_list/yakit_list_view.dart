import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yakit_takip_2022/navigation/navigation_services.dart';

import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';
import 'package:yakit_takip_2022/view/yakit_ekleme/yakit_ekleme_view_model.dart';

import '../../../model/delet_model.dart';
import '../../../navigation/navigation_route_services.dart';

class YakitListView extends StatelessWidget {
  const YakitListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<HomeAndYakitListViewModel>(builder: (context, value, child) => child!, child: const Text("Yakit L")),
      ),
      body: Consumer<HomeAndYakitListViewModel>(builder: (context, viewModel, child) {
        return ListView.builder(
          itemCount: viewModel.listYakitIslemModel.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(viewModel.listYakitIslemModel[index]!.aracKm.toString()),
              leading: Text(viewModel.listYakitIslemModel[index]!.miktari == null ? "yok" : viewModel.listYakitIslemModel[index]!.miktari.toString()),
              onTap: () {
                goToWiewPush<DeletModel>(
                    path: NavigationEnum.yakitGuncelleme,
                    args: YakitEklemeViewModel.show(yakitIslemModel: viewModel.listYakitIslemModel[index]!, carModel: viewModel.carModel),
                    function: (gelenModel) {
                      if (gelenModel.isDelet) {
                        viewModel.delete(gelenModel.model);
                      } else {
                        viewModel.modelUpdate(gelenModel.model);
                      }
                    });
              },
            );
          },
        );
      }),
    );
  }
}

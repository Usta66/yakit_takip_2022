// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';

import 'package:yakit_takip_2022/navigation/navigation_services.dart';
import 'package:yakit_takip_2022/view/home_and_yakit_list/home/home_view.dart';

import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';
import 'package:yakit_takip_2022/view/home_and_yakit_list/yakit_list/yakit_list_view.dart';

import '../../navigation/navigation_route_services.dart';
import '../../services/admob_service.dart';
import '../yakit_ekleme/yakit_ekleme_view_model.dart';

class HomeAndYakitListView extends StatelessWidget {
  const HomeAndYakitListView({Key? key, required this.viewModel}) : super(key: key);
  final HomeAndYakitListViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: viewModel,
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (AdmobService.instance!.getIsInterstitialAdReady) {
                AdmobService.instance!.getInterstitialAd.show();
              }

              goToViewPush<YakitIslemModel>(
                  path: NavigationEnum.yakitEkleme,
                  args: YakitEklemeViewModel.addNew(carModel: viewModel.carModel, yakitHesapModel: viewModel.yakitHesapModel),
                  function: (gelenModel) {
                    viewModel.modelInsert(gelenModel);
                  });
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: const TabBar(tabs: [
            Tab(
              icon: Icon(
                Icons.car_repair,
                color: const Color(0xFF871092),
              ),
            ),
            const Tab(
              icon: const Icon(
                Icons.local_gas_station_outlined,
                color: const Color(0xFF871092),
              ),
            )
          ]),
          body: const TabBarView(
            children: [HomeView(), YakitListView()],
          ),
        ),
      ),
    );
  }
}

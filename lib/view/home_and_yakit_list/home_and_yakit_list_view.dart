// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/view/home/home_view.dart';
import 'package:yakit_takip_2022/view/home/home_view_model.dart';
import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';
import 'package:yakit_takip_2022/view/yakit_list/yakit_list_view.dart';

import '../yakit_ekleme/yakit_ekleme_view.dart';
import '../yakit_ekleme/yakit_ekleme_view_model.dart';
import '../yakit_list/yakit_list_vie_model.dart';

class HomeAndYakitListView extends StatelessWidget {
  const HomeAndYakitListView({Key? key, required this.viewModel}) : super(key: key);
  final HomeAndYakitListViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => YakitEklemeView(viewModel: YakitEklemeViewModel())));
          },
        ),
        bottomNavigationBar: TabBar(tabs: [
          const Tab(
            icon: Icon(
              Icons.car_repair,
              color: const Color(0xFF871092),
            ),
          ),
          const Tab(
            icon: Icon(
              Icons.local_gas_station_outlined,
              color: Color(0xFF871092),
            ),
          )
        ]),
        body: TabBarView(
          children: [HomeView(viewModel: HomeViewModel(carModel: viewModel.carModel)), YakitListView(viewModel: YakitListViewModel())],
        ),
      ),
    );
  }
}

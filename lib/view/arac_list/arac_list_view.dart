import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/navigation/navigation_enum.dart';
import 'package:yakit_takip_2022/navigation/navigation_services.dart';
import 'package:yakit_takip_2022/services/database_service.dart';
import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';
import 'package:yakit_takip_2022/view/home/home_view.dart';
import 'package:yakit_takip_2022/view/home/home_view_model.dart';
import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view.dart';
import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';

import '../add_new_car/add_new_car_view.dart';
import '../add_new_car/add_new_car_view_model.dart';

class AracListView extends StatelessWidget {
  final AracListViewModel viewModel;
  const AracListView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("view çalıştı");
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Araç Listesi"),
          ),
          body: Consumer<AracListViewModel>(
            builder: (context, db, child) {
              return ListView.builder(
                  itemCount: viewModel.listCarModel.length,
                  itemBuilder: (context, index) {
                    CarModel carModel = viewModel.listCarModel[index]!;
                    return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<CarModel>(
                                builder: (context) => HomeAndYakitListView(
                                    viewModel: HomeAndYakitListViewModel(
                                        carModel: carModel)),
                              ));
                        },
                        onLongPress: () {
                          goToWiewPush<CarDeletModel>(
                              path: NavigationEnum.aracGuncelleme,
                              args: AddNewCarViewModel.show(carModel: carModel),
                              function: (gelenModel) {
                                if (gelenModel.isDelet) {
                                  viewModel.delete(gelenModel.carModel);
                                } else {
                                  viewModel.modelUpdate(gelenModel.carModel);
                                }
                              });

                      
                        },
                        title:
                            Text(viewModel.listCarModel[index]!.adi ?? "yok"));
                  });
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              goToWiewPush<CarModel>(
                  path: NavigationEnum.aracEkleme,
                  function: (carModel) {
                    viewModel.modelInsert(carModel);
                  });

              /*     NavigationServices.instance
                  .navigatePush<CarModel>(path: NavigationEnum.aracEkleme)
                  .then((value) {
                if (value != null) {
                  viewModel.modelInsert(value);
                }
              }); */

              /*    Navigator.push<CarModel>(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddNewCarView(
                              viewModel: AddNewCarViewModel.addNew())))
                  .then((value) {
                if (value != null) {
                  viewModel.modelInsert(value);
                }
              }); */
            },
          ),
        ));
  }
}

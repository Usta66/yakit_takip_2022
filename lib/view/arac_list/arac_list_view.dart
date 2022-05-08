import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/circle_avatar_image_and_alphabet.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/navigation/navigation_enum.dart';
import 'package:yakit_takip_2022/navigation/navigation_services.dart';

import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';

import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view.dart';
import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';

import '../../model/delet_model.dart';

import '../add_new_car/add_new_car_view_model.dart';
import 'package:kartal/kartal.dart';

class AracListView extends StatelessWidget {
  final AracListViewModel viewModel;
  const AracListView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
          key: viewModel.scaffoldKey,
          appBar: AppBar(
            title: const Text("Araç Listesi"),
          ),
          body: Padding(
            padding: context.paddingNormal,
            child: Consumer<AracListViewModel>(
              builder: (context, db, child) {
                return ListView.builder(
                    itemCount: viewModel.listCarModel.length,
                    itemBuilder: (context, index) {
                      CarModel carModel = viewModel.listCarModel[index]!;
                      return Card(
                        child: Slidable(
                          endActionPane: ActionPane(
                              extentRatio: 0.50,
                              motion: BehindMotion(),
                              children: [
                                SlidableAction(
                                  backgroundColor: Colors.blueAccent,
                                  label: "Güncelle",
                                  onPressed: (context) {
                                    goToWiewPush<CarModel>(
                                        path: NavigationEnum.aracGuncelleme,
                                        args: AddNewCarViewModel.show(
                                            carModel: carModel),
                                        function: (gelenModel) {
                                          viewModel.modelUpdate(gelenModel);
                                        });
                                  },
                                  icon: Icons.update_rounded,
                                ),
                                SlidableAction(
                                    backgroundColor: Colors.redAccent,
                                    label: "Sil",
                                    onPressed: (context) {
                                      viewModel.delete(carModel);
                                    },
                                    icon: Icons.delete)
                              ]),
                          child: Padding(
                            padding: context.paddingLow,
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: CircleAvatarImageAndAlphabet(
                                      radius: context.width * 0.15,
                                      color: carModel.color,
                                      imagePath: carModel.imagePath,
                                      text: carModel.adi != null
                                          ? carModel.adi![0]
                                          : null),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Text(
                                        carModel.adi ?? " ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                        textAlign: TextAlign.center,
                                      ),
                                      Text("120.000 KM")
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "1.5",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text("5.8",
                                          style: TextStyle(color: Colors.red))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [Text("TL/KM"), Text("L/100KM")],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              goToWiewPush<CarModel>(
                  path: NavigationEnum.aracEkleme,
                  function: (carModel) {
                    viewModel.modelInsert(carModel);
                  });
            },
          ),
        ));
  }
}

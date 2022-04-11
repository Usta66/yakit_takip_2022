import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view.dart';
import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view_model.dart';
import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';
import 'package:yakit_takip_2022/view/home/home_view.dart';
import 'package:yakit_takip_2022/view/home/home_view_model.dart';

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
          appBar: AppBar(
            title: Text("Araç Listesi"),
          ),
          body: Consumer<AracListViewModel>(
            builder: (context, viewModel, child) {
              return ListView.builder(
                  itemCount: viewModel.listCarModel.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                           onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<CarModel>(
                                  builder: (context) => HomeView(viewModel: HomeViewModel(carModel:viewModel.listCarModel[index]! )),
                                  ));
                        },
                        title:
                            Text(viewModel.listCarModel[index]!.adi ?? "yok"));
                  });
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push<CarModel>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddNewCarView(viewModel: AddNewCarViewModel.addNew()),
                  )).then((value) {
                if (value != null) {
                  viewModel.modelInsert(value);
                }
              });
            },
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';

class AracListView extends StatelessWidget {
  const AracListView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  void initState() {
    Future.microtask(() => null);
  }

  final AracListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Araç Listesi"),
            ),
            body: FloatingActionButton(
              onPressed: () async {
                viewModel.yaz();
              },
            )

            /*         FutureBuilder<List<CarModel?>>(
              future: DatabaseService.instance!.getModelList<CarModel>(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      if (snapshot.hasData) {
                        return ListTile(
                          title: Text(snapshot.data![index]!.adi ?? "aaa"),
                        );
                      } else {
                        return Text("data");
                      }
                      ;
                    },
                  );
                } else {
                  return Text("aaaa");
                }
              },
            ) */

            ));
  }
}

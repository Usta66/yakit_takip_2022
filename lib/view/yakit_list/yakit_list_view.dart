import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/services/database_service.dart';
import 'package:yakit_takip_2022/view/yakit_list/yakit_list_vie_model.dart';

class YakitListView extends StatelessWidget {
  const YakitListView({Key? key, required this.viewModel}) : super(key: key);

  final YakitListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    print("yakit listesi");
    return

        /*     BaseView(
        viewModel: viewModel,
        child: */

        ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<YakitListViewModel>(builder: (context, value, child) => child!, child: Text("Yakit L")),
        ),
        body: Consumer<DatabaseService>(builder: (context, value, child) {
          return ListView.builder(
            itemCount: viewModel.listYakitIslemModel.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(viewModel.listYakitIslemModel[index]!.id.toString()),
              );
            },
          );
        }),
      ),
    );
  }
}

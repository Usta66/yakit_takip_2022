import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/components/base_text_field.dart';
import 'package:yakit_takip_2022/services/database_service.dart';
import 'package:yakit_takip_2022/view/home/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final HomeViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    print("home");
    return

/*     BaseView(
      viewModel: viewModel,
      child: */

        ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: SingleChildScrollView(child: Consumer<DatabaseService>(
          builder: (context, value, child) {
            return Column(
              children: [
                BaseTextField(controller: viewModel.controllerAdi, readOnly: true),
                BaseTextField(
                  controller: viewModel.controllerYakitTuru,
                  readOnly: true,
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}

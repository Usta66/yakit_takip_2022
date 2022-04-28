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
    print("home");
    return

/*     BaseView(
      viewModel: viewModel,
      child: */

        Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(child: Consumer<HomeAndYakitListViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              BaseTextField(controller: viewModel.controllerAdi, readOnly: true),
              BaseTextField(
                controller: viewModel.controllerYakitTuru,
                readOnly: true,
              ),
              Consumer<HomeAndYakitListViewModel>(
                builder: (context, value, child) {
                  return TextField(
                    controller: viewModel.controllerMiktar,
                  );
                },
              ),
              ElevatedButton(onPressed: () async {}, child: Text("data"))
            ],
          );
        },
      )),
    );
  }
}

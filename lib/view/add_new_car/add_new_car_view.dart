import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:provider/provider.dart';

import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/base_text_field.dart';
import 'package:yakit_takip_2022/components/circle_avatar_image_and_alphabet.dart';
import 'package:yakit_takip_2022/components/yakit_turu_secim_dialog.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';

import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view_model.dart';

import '../../model/car_model.dart';
import '../../model/delet_model.dart';
import 'package:kartal/kartal.dart';

class AddNewCarView extends StatelessWidget {
  const AddNewCarView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AddNewCarViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    print("build calışyti" * 10);
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
            appBar: AppBar(title: viewModel.isNew ? Text("Yeni Araç Ekle") : Text("Güncelle")),
            body: SingleChildScrollView(
              child: Center(
                  child: Padding(
                      padding: context.paddingLow,
                      child: Wrap(
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            IconButton(
                                onPressed: () {
                                  viewModel.getImage(false);
                                },
                                icon: const Icon(Icons.add_a_photo_outlined)),
                            Consumer<AddNewCarViewModel>(
                              builder: (context, value, child) {
                                return CircleAvatarImageAndAlphabet(
                                  color: Color(viewModel.color),
                                  imagePath: viewModel.image == null ? null : viewModel.image!.path,
                                  radius: context.highValue,
                                  text: viewModel.controllerAdi.text.isEmpty ? null : viewModel.controllerAdi.text,
                                  onTap: () {
                                    viewModel.renkSec(context);
                                  },
                                );
                              },
                            ),
                            IconButton(
                                onPressed: () {
                                  viewModel.getImage(true);
                                },
                                icon: const Icon(Icons.file_upload))
                          ]),
                          BaseTextField(
                            hintText: "Adı",
                            controller: viewModel.controllerAdi,
                            onChanged: (value) {
                              //viewModel.setState();
                            },
                          ),
                          BaseTextField(
                              hintText: "Yakıt Türü",
                              controller: viewModel.controllerYakitTuru,
                              readOnly: true,
                              onTap: () {
                                return showDialog<YakitTuruEnum>(
                                    context: context,
                                    builder: (context) {
                                      return const YakitTuruSecimDialog();
                                    }).then((value) {
                                  if (value != null) {
                                    viewModel.controllerYakitTuru.text = value.name;
                                  }
                                });
                              }),
                          Consumer<AddNewCarViewModel>(
                            builder: (context, value, child) => Visibility(
                              visible: viewModel.controllerYakitTuru.text == YakitTuruEnum.LPG.name,
                              child: BaseTextField(hintText: "LPG Depo Kapasite", controller: viewModel.controllerLpgDepo),
                            ),
                          ),
                          BaseTextField(hintText: "Akaryakıt Depo Kapasite", controller: viewModel.controllerAracDepo),
                          Center(
                            child: viewModel.isNew
                                ? ElevatedButton(
                                    onPressed: () async {
                                      Navigator.pop<CarModel>(context, viewModel.modeliHazirla());
                                    },
                                    child: const Text("Kaydet"))
                                : Row(children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop<DeletModel<CarModel>>(
                                              context, DeletModel<CarModel>(model: viewModel.modeliHazirla(), isDelet: false));
                                        },
                                        child: Text("Güncelle")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop<DeletModel>(context, DeletModel<CarModel>(model: viewModel.modeliHazirla(), isDelet: true));
                                        },
                                        child: Text("Sil"))
                                  ]),
                          )
                        ],
                      ))),
            )));
  }
}

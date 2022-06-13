import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/base_text_field.dart';
import 'package:yakit_takip_2022/components/circle_avatar_image_and_alphabet.dart';

import 'package:yakit_takip_2022/components/yakit_turu_secim_dialog.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:yakit_takip_2022/utils/validator.dart';

import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view_model.dart';

import '../../model/car_model.dart';

import 'package:kartal/kartal.dart';

class AddNewCarView extends StatelessWidget with Validator {
  const AddNewCarView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AddNewCarViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
            appBar: AppBar(title: viewModel.isNew ? Text("Yeni Araç Ekle") : Text("Güncelle"), actions: [
              Padding(
                padding: context.paddingLow,
                child: IconButton(
                  onPressed: () {
                    viewModel.formKey.currentState!.validate() ? Navigator.pop<CarModel>(context, viewModel.modeliHazirla()) : null;
                  },
                  icon: Icon(Icons.check),
                  iconSize: context.mediumValue,
                  color: Colors.amber,
                ),
              )
            ]),
            body: SingleChildScrollView(
              child: Center(
                  child: Padding(
                      padding: context.paddingMedium,
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
                                  color: viewModel.color,
                                  imagePath: viewModel.image == null ? null : viewModel.image!.path,
                                  radius: context.width * 0.2,
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
                          Form(
                            key: viewModel.formKey,
                            child: Column(
                              children: [
                                BaseTextFormField(labelText: "Adı", controller: viewModel.controllerAdi, validator: (value) => bosOlamaz(value)),
                                BaseTextFormField(
                                    validator: (value) => bosOlamaz(value),
                                    labelText: "Araçın KM'si",
                                    keyboardType: TextInputType.number,
                                    controller: viewModel.controllerAracKm),
                                BaseTextFormField(
                                    labelText: "Yakıt Türü",
                                    controller: viewModel.controllerYakitTuru,
                                    readOnly: true,
                                    validator: (value) => bosOlamaz(value),
                                    onTap: () {
                                      showDialog<YakitTuruEnum>(
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
                                    child: BaseTextFormField(
                                        keyboardType: TextInputType.number, labelText: "LPG Depo Kapasite", controller: viewModel.controllerLpgDepo),
                                  ),
                                ),
                                BaseTextFormField(
                                    labelText: "Akaryakıt Depo Kapasite",
                                    keyboardType: TextInputType.number,
                                    controller: viewModel.controllerAracDepo),
                              ],
                            ),
                          ),
                        ],
                      ))),
            )));
  }
}

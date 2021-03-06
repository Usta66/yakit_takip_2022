import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:provider/provider.dart';

import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/base_text_field.dart';
import 'package:yakit_takip_2022/components/circle_avatar_image_and_alphabet.dart';

import 'package:yakit_takip_2022/components/yakit_turu_secim_dialog.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:yakit_takip_2022/navigation/navigation_route_services.dart';
import 'package:yakit_takip_2022/navigation/navigation_services.dart';
import 'package:yakit_takip_2022/utils/locale_keys.g.dart';
import 'package:yakit_takip_2022/utils/validator.dart';

import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view_model.dart';

import '../../components/my_app_bar.dart';
import '../../components/my_app_bar_action_button.dart';
import '../../components/my_banner_adwidget.dart';
import '../../init/cache/enum_preferences_keys.dart';
import '../../init/cache/locale_maneger.dart';
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
    viewModel.admobShow();

    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
          appBar: MyAppBar(
            label: viewModel.isNew ? LocaleKeys.add_new_car_yeniAracEkle : LocaleKeys.guncelle,
            actions: [
              MyAppBarActionButton(
                onPressed: () async {
                  if (viewModel.formKey.currentState!.validate()) {
                    if (viewModel.isOpen == null || viewModel.isOpen == false) {
                      await viewModel.modelInsert(viewModel.modeliHazirla());
                      LocaleManeger.instance.setBoolValue(EnumPreferencesKeys.ISFIRSTOPEN, true);
                      goToViewPush(path: NavigationEnum.aracListesi);
                    } else {
                      Navigator.pop<CarModel>(context, viewModel.modeliHazirla());
                    }
                  }
                },
              ),
            ],
            context: context,
          ),
          body: _buildBody(context),
          bottomNavigationBar: const MyBannerAdWidget(size: AdSize.largeBanner),
        ));
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
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
                        BaseTextFormField(
                            labelText: LocaleKeys.add_new_car_adi, controller: viewModel.controllerAdi, validator: (value) => bosOlamaz(value)),
                        BaseTextFormField(
                          validator: (value) => bosOlamaz(value),
                          labelText: LocaleKeys.add_new_car_aracKm,
                          keyboardType: TextInputType.number,
                          controller: viewModel.controllerAracKm,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*'))],
                        ),
                        BaseTextFormField(
                            labelText: LocaleKeys.add_new_car_yakitTuru,
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
                                  viewModel.controllerYakitTuru.text = value.name.tr().toUpperCase();
                                }
                              });
                            }),
                        Consumer<AddNewCarViewModel>(
                          builder: (context, value, child) => Visibility(
                            visible: viewModel.controllerYakitTuru.text == YakitTuruEnum.LPG.name,
                            child: BaseTextFormField(
                                keyboardType: TextInputType.number,
                                labelText: LocaleKeys.add_new_car_lpgDepoKapasite,
                                controller: viewModel.controllerLpgDepo),
                          ),
                        ),
                        BaseTextFormField(
                            labelText: LocaleKeys.add_new_car_akaryakitDepoKapasitesi,
                            keyboardType: TextInputType.number,
                            controller: viewModel.controllerAracDepo),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}

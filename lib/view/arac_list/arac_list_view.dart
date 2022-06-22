import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/components/circle_avatar_image_and_alphabet.dart';
import 'package:yakit_takip_2022/components/my_app_bar.dart';
import 'package:yakit_takip_2022/constants/app_constants.dart';

import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:yakit_takip_2022/navigation/navigation_services.dart';

import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';
import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';

import '../../components/locale_text.dart';
import '../../components/my_banner_adwidget.dart';
import '../../navigation/navigation_route_services.dart';
import '../../utils/locale_keys.g.dart';
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
          appBar: MyAppBar(
            context: context,
            label: LocaleKeys.aracList_aracListesi,
            centerTitle: true,
          ),
          drawer: buildDrawer(context),
          body: buildBody(context),
          bottomNavigationBar: const MyBannerAdWidget(size: AdSize.largeBanner),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              goToViewPush<CarModel>(
                  path: NavigationEnum.aracEkleme,
                  function: (carModel) {
                    viewModel.modelInsert(carModel);
                  });
            },
          ),
        ));
  }

  Drawer buildDrawer(BuildContext context) {
    const String email = "mailto:veysel.karabacak66@gmail.com?subject=Yakit Takip Uygulaması Hakkında&body=";
    const String playStoreUrl = "https://play.google.com/store/apps/details?id=com.yakit_takip_uygulamasi";
    const String version = "v.1.0.0";
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.amber),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: Lottie.asset(LottieConstants.instance!.GAS_STATION)),
                Expanded(
                  flex: 3,
                  child: LocaleText(
                    LocaleKeys.aracList_uygulamaAdi,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: context.paddingLow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocaleText(LocaleKeys.aracList_hakkinda, style: Theme.of(context).textTheme.subtitle1),
                  const LocaleText(LocaleKeys.aracList_hakkindaText)
                ],
              )),
          const Divider(),
          Padding(
            padding: context.paddingLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LocaleText(LocaleKeys.dil, style: Theme.of(context).textTheme.subtitle1),
                Center(
                  child: DropdownButton<String>(
                      hint: LocaleText(context.locale.languageCode == "en" ? LocaleKeys.aracList_ingilizce : LocaleKeys.aracList_turkce),
                      items: const [
                        DropdownMenuItem<String>(child: LocaleText(LocaleKeys.aracList_turkce), value: "tr"),
                        DropdownMenuItem<String>(child: LocaleText(LocaleKeys.aracList_ingilizce), value: "en")
                      ],
                      onChanged: (value) {
                        if (value == "tr") {
                          context.setLocale(LocaleConstants.TR_LOCALE);
                        } else if (value == "en") {
                          context.setLocale(LocaleConstants.EN_LOCALE);
                        }
                      }),
                )
              ],
            ),
          ),
          const Divider(),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    final Uri _url = Uri.parse(email);

                    launchUrl(_url);
                  },
                  icon: const FaIcon(FontAwesomeIcons.envelope)),
              IconButton(
                  onPressed: () {
                    final Uri _url = Uri.parse(playStoreUrl);

                    launchUrl(_url);
                  },
                  icon: const FaIcon(FontAwesomeIcons.googlePlay))
            ],
          ),
          const Divider(),
          Padding(padding: EdgeInsets.only(left: context.normalValue), child: const Text(version)),
        ],
      ),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Consumer<AracListViewModel>(
        builder: (context, db, child) {
          return ListView.builder(
              itemCount: viewModel.listCarModel.length,
              itemBuilder: (context, index) {
                CarModel carModel = viewModel.listCarModel[index]!;
                return Card(
                  child: Slidable(
                    endActionPane: ActionPane(extentRatio: 0.50, motion: const BehindMotion(), children: [
                      SlidableAction(
                        backgroundColor: Colors.blueAccent,
                        label: LocaleKeys.guncelle.tr(),
                        onPressed: (context) {
                          goToViewPush<CarModel>(
                              path: NavigationEnum.aracGuncelleme,
                              args: AddNewCarViewModel.show(carModel: carModel),
                              function: (gelenModel) {
                                viewModel.modelUpdate(gelenModel);
                              });
                        },
                        icon: Icons.update_rounded,
                      ),
                      SlidableAction(
                          backgroundColor: Colors.redAccent,
                          label: LocaleKeys.sil.tr(),
                          onPressed: (context) {
                            viewModel.delete(carModel);
                          },
                          icon: Icons.delete)
                    ]),
                    child: Padding(
                      padding: context.paddingLow,
                      child: GestureDetector(
                        onTap: () {
                          goToViewPush(
                              path: NavigationEnum.homeAndYakitList,
                              args: HomeAndYakitListViewModel(carModel: carModel, aracListViewModel: viewModel));
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CircleAvatarImageAndAlphabet(
                                  radius: context.width * 0.15,
                                  color: carModel.color,
                                  imagePath: carModel.imagePath,
                                  text: carModel.adi != null ? carModel.adi![0] : null),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: context.lowValue),
                                child: Column(
                                  children: [
                                    AutoSizeText(
                                      carModel.adi ?? "---",
                                      style: Theme.of(context).textTheme.headline5,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    AutoSizeText("${carModel.aracKm} ${StringConstants.km}",
                                        style: Theme.of(context).textTheme.subtitle1, maxLines: 1),
                                    Text(carModel.yakitTuru!.name.tr(), style: Theme.of(context).textTheme.subtitle2)
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                  carModel.ortalamaTl == null ? "---" : carModel.ortalamaTl.toString(),
                                  style: const TextStyle(color: Colors.red, fontSize: 30),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                )),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(StringConstants.tlKm, style: Theme.of(context).textTheme.subtitle1)],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

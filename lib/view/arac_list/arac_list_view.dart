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
import 'package:yakit_takip_2022/init/cache/locale_maneger.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:yakit_takip_2022/navigation/navigation_services.dart';
import 'package:yakit_takip_2022/services/admob_service.dart';

import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';
import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';

import '../../components/my_banner_adwidget.dart';
import '../../navigation/navigation_route_services.dart';
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
            label: "Araç Listesi",
            centerTitle: true,
          ),
          drawer: buildDrawer(context),
          body: buildBody(context),
          bottomNavigationBar: const MyBannerAdWidget(size: AdSize.largeBanner),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              if (AdmobService.instance!.getIsInterstitialAdReady) {
                AdmobService.instance!.getInterstitialAd.show();
              }

              goToWiewPush<CarModel>(
                  path: NavigationEnum.aracEkleme,
                  function: (carModel) {
                    viewModel.modelInsert(carModel);
                  });
            },
          ),
        ));
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.amber),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Lottie.asset(LottieConstants.instance!.GAS_STATION)),
                Expanded(
                  child: Text(
                    "Yakıt Takip Uygulaması",
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
                  Text("Hakkında",
                      style: Theme.of(context).textTheme.subtitle1),
                  const Text(
                      "Bu uygulama aracınızın yakıt tüketimini tüm detaylarıyla takip edebilmeniz amaçıyla geliştirilmiştir.")
                ],
              )),
          const Divider(),
          Padding(
            padding: context.paddingLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("dil".tr(), style: Theme.of(context).textTheme.subtitle1),
                Center(
                  child: DropdownButton<String>(
                      hint: Text(context.locale.languageCode == "en"
                          ? "English"
                          : "Türkçe"),
                      items: const [
                        DropdownMenuItem<String>(
                            child: Text("Türkçe"), value: "tr"),
                        DropdownMenuItem<String>(
                            child: Text("English"), value: "en")
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
                    final Uri _url = Uri.parse(
                        "mailto:veysel.karabacak66@gmail.com?subject=Yakit Takip Uygulaması Hakkında&body=");

                    launchUrl(_url);
                  },
                  icon: FaIcon(FontAwesomeIcons.envelope)),
              IconButton(
                  onPressed: () {
                    final Uri _url = Uri.parse(
                        "https://play.google.com/store/apps/details?id=com.veyselkarabacak.square_app");

                    launchUrl(_url);
                  },
                  icon: FaIcon(FontAwesomeIcons.googlePlay))
            ],
          ),
          const Divider(),
          Padding(
              padding: EdgeInsets.only(left: context.normalValue),
              child: const Text("v.1.0.0")),
          TextButton(
              onPressed: () {
                LocaleManeger.instance.clear();
                goToWiewPush(path: NavigationEnum.onboard);
              },
              child: Text("cache temizle"))
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
                    endActionPane: ActionPane(
                        extentRatio: 0.50,
                        motion: const BehindMotion(),
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
                      child: GestureDetector(
                        onTap: () {
                          goToWiewPush(
                              path: NavigationEnum.homeAndYakitList,
                              args: HomeAndYakitListViewModel(
                                  carModel: carModel,
                                  aracListViewModel: viewModel));
                        },
                        child: Row(
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
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text("${carModel.aracKm} KM",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  Text(carModel.yakitTuru!.name,
                                      style:
                                          Theme.of(context).textTheme.subtitle2)
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  carModel.ortalamaTl.toString(),
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 30),
                                )),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("TL/KM",
                                      style:
                                          Theme.of(context).textTheme.subtitle1)
                                ],
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

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';

import 'package:yakit_takip_2022/navigation/navigation_services.dart';

import 'package:yakit_takip_2022/view/home_and_yakit_list/home_and_yakit_list_view_model.dart';
import 'package:yakit_takip_2022/view/yakit_ekleme/yakit_ekleme_view_model.dart';

import '../../../components/circle_avatar_image_and_alphabet.dart';

import '../../../components/my_app_bar.dart';
import '../../../navigation/navigation_route_services.dart';
import '../../../utils/date_time_extension.dart';

class YakitListView extends StatelessWidget {
  const YakitListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        label: "Yakıt Listesi",
      ),
      body: _buildBody(),
    );
  }

  Consumer<HomeAndYakitListViewModel> _buildBody() {
    return Consumer<HomeAndYakitListViewModel>(builder: (context, viewModel, child) {
      return ListView.builder(
        itemCount: viewModel.listYakitIslemModel.length,
        itemBuilder: (context, index) {
          YakitIslemModel yakitIslemModel = viewModel.listYakitIslemModel[index]!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Slidable(
                endActionPane: ActionPane(extentRatio: 0.50, motion: const BehindMotion(), children: [
                  SlidableAction(
                    backgroundColor: Colors.blueAccent,
                    label: "Güncelle",
                    onPressed: (context) {
                      goToWiewPush<YakitIslemModel>(
                          path: NavigationEnum.yakitGuncelleme,
                          args: YakitEklemeViewModel.show(
                              yakitIslemModel: viewModel.listYakitIslemModel[index]!,
                              carModel: viewModel.carModel,
                              yakitHesapModel: viewModel.yakitHesapModel,
                              index: index),
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
                        viewModel.delete(viewModel.listYakitIslemModel[index]!);
                      },
                      icon: Icons.delete)
                ]),
                child: Padding(
                  padding: context.paddingLow,
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Expanded(
                          child: CircleAvatarImageAndAlphabet(
                              color: yakitIslemModel.yakitTuru == YakitTuruEnum.LPG ? 0x4D05FF3B : 0x989F0D7D,
                              radius: context.width * 0.15,
                              text: yakitIslemModel.yakitTuru != null ? yakitIslemModel.yakitTuru!.name : null),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text("Tarih", style: Theme.of(context).textTheme.subtitle1),
                              Text(yakitIslemModel.alisTarihi!.stringValue, style: Theme.of(context).textTheme.subtitle2),
                              Padding(
                                padding: EdgeInsets.only(top: context.lowValue),
                                child: Text("Km", style: Theme.of(context).textTheme.subtitle1),
                              ),
                              Text("${yakitIslemModel.aracKm} KM", style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text("Miktar", style: Theme.of(context).textTheme.subtitle1),
                              Text("${yakitIslemModel.miktari} L", style: Theme.of(context).textTheme.subtitle2),
                              Padding(
                                padding: EdgeInsets.only(top: context.lowValue),
                                child: Text("Tutar", style: Theme.of(context).textTheme.subtitle1),
                              ),
                              Text("${yakitIslemModel.tutar} TL", style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text("Fiyat", style: Theme.of(context).textTheme.subtitle1),
                              Text("${yakitIslemModel.fiyati} TL", style: Theme.of(context).textTheme.subtitle2),
                              Padding(
                                padding: EdgeInsets.only(top: context.lowValue),
                                child: Text("Mesafe", style: Theme.of(context).textTheme.subtitle1),
                              ),
                              Text("${viewModel.mesafeHesapla(index) ?? "---"} KM", style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

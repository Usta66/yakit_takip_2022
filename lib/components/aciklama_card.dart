import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:yakit_takip_2022/model/yakit_hesap_model.dart';
import 'package:yakit_takip_2022/utils/date_time_extension.dart';

class AciklamaCard extends StatelessWidget {
  const AciklamaCard({Key? key, required this.yakitHesapModel, required this.isLPG}) : super(key: key);
  final YakitHesapModel yakitHesapModel;
  final bool isLPG;

  @override
  Widget build(BuildContext context) {
    return isLPG
        ? Card(
            child: yakitHesapModel.listYakitIslemModelLpg.isNotNullOrEmpty
                ? Padding(
                    padding: context.paddingLow,
                    child: Text(
                      "${yakitHesapModel.listYakitIslemModelLpg.first!.alisTarihi!.stringValue} tarihinden itibaren tolpam ${yakitHesapModel.listYakitIslemModelLpg.length} kez LPG alınmış olup ortalam LPG fiyatı ${yakitHesapModel.ortalamaLpgMaliyeti} TL'dir.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  )
                : const Text(""),
          )
        : Card(
            child: yakitHesapModel.listYakitIslemModelAkaryakit.isNotNullOrEmpty
                ? Padding(
                    padding: context.paddingLow,
                    child: Text(
                      "${yakitHesapModel.listYakitIslemModelAkaryakit.first!.alisTarihi!.stringValue} tarihinden itibaren tolpam ${yakitHesapModel.listYakitIslemModelAkaryakit.length} kez Akaryakıt alınmış olup ortalam Akaryakıt fiyatı ${yakitHesapModel.ortalamaAkaryakitMaliyeti} TL'dir.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  )
                : Text(""),
          );
  }
}

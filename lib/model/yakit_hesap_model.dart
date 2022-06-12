import 'package:yakit_takip_2022/services/database_service.dart';

import '../enum/yakit_turu_enum.dart';
import 'car_model.dart';
import 'yakit_islem_model.dart';

class YakitHesapModel {
  late List<YakitIslemModel?> listYakitIslemModel;
  final CarModel carModel;
  late String toplamLpgMiktari;
  late String toplamLpgMaliyeti;
  late String toplamAkaryakitMiktari;
  late String toplamAkaryakitMaliyeti;
  late String toplamMaliyet;
  late String toplamKm;
  late String tLKm;
  late String tLKmLpg;
  late String tlKmAkaryakit;
  late String litreKmLpg;
  late String litreKmAkaryakit;
  late String sonKm;
  late List<YakitIslemModel?> listYakitIslemModelLpg;
  late List<YakitIslemModel?> listYakitIslemModelAkaryakit;
  late String ortalamaLpgMaliyeti;
  late String ortalamaAkaryakitMaliyeti;

  YakitHesapModel({required this.carModel}) {
    init();
  }

  Future<void> init() async {
    listYakitIslemModel = await DatabaseService.instance!
        .getAracYakitListesi(aracId: carModel.id!);

    toplamLpgMiktari = getToplamLpgMiktari();
    toplamLpgMaliyeti = getToplamLpgMaliyeti();

    toplamAkaryakitMiktari = getToplamAkaryakitMiktari();
    toplamAkaryakitMaliyeti = getToplamAkaryakitMaliyeti();
    toplamMaliyet = getToplamMaliyet();
    toplamKm = getToplamKm();
    tLKm = getTlKm();
    tLKmLpg = getTlKmLpg();
    tlKmAkaryakit = getTlKmAkaryakit();
    litreKmLpg = getLitreKmLpg();
    litreKmAkaryakit = getLitreKmAkaryakit();

    listYakitIslemModelLpg = getListYakitIslemModelLpg();
    listYakitIslemModelAkaryakit = getListYakitIslemModelAkaryakit();

    listYakitIslemModel.sort((a, b) => a!.aracKm!.compareTo(b!.aracKm!));

    listYakitIslemModelLpg.sort((a, b) => a!.aracKm!.compareTo(b!.aracKm!));

    ortalamaLpgMaliyeti = getOrtalamLpgMaliyet();
    ortalamaAkaryakitMaliyeti = getOrtalamaAkaryakitMaliyeti();

    sonKm = getSonKm();
  }

  Future<List<YakitIslemModel?>> getYakitislemModel() async {
    return await DatabaseService.instance!
        .getAracYakitListesi(aracId: carModel.id!);
  }

  String getToplamLpgMiktari() {
    double tuketilenLpgMiktari = 0;

    if (listYakitIslemModel.isNotEmpty &&
        carModel.yakitTuru == YakitTuruEnum.LPG) {
      var result = listYakitIslemModel
          .where((element) => element!.yakitTuru == YakitTuruEnum.LPG);

      for (var element in result) {
        if (element!.miktari != null) {
          tuketilenLpgMiktari = tuketilenLpgMiktari + element.miktari!;
        }
      }
    }

    return tuketilenLpgMiktari.toStringAsFixed(2);
  }

  String getToplamLpgMaliyeti() {
    double tuketilenLpgMaliyeti = 0;

    if (listYakitIslemModel.isNotEmpty &&
        carModel.yakitTuru == YakitTuruEnum.LPG) {
      var result = listYakitIslemModel
          .where((element) => element!.yakitTuru == YakitTuruEnum.LPG);

      for (var element in result) {
        if (element!.tutar != null) {
          tuketilenLpgMaliyeti = tuketilenLpgMaliyeti + element.tutar!;
        }
      }
    }

    return tuketilenLpgMaliyeti.toStringAsFixed(2);
  }

  String getToplamAkaryakitMiktari() {
    double tuketilenToplamAkaryakitMiktari = 0;

    if (listYakitIslemModel.isNotEmpty) {
      var result = listYakitIslemModel
          .where((element) => element!.yakitTuru != YakitTuruEnum.LPG);

      for (var element in result) {
        if (element!.miktari != null) {
          tuketilenToplamAkaryakitMiktari =
              tuketilenToplamAkaryakitMiktari + element.miktari!;
        }
      }
    }

    return tuketilenToplamAkaryakitMiktari.toStringAsFixed(2);
  }

  String getToplamAkaryakitMaliyeti() {
    double tuketilenToplamAkaryakitMaliyeti = 0;

    if (listYakitIslemModel.isNotEmpty) {
      var result = listYakitIslemModel
          .where((element) => element!.yakitTuru != YakitTuruEnum.LPG);

      for (var element in result) {
        if (element!.tutar != null) {
          tuketilenToplamAkaryakitMaliyeti =
              tuketilenToplamAkaryakitMaliyeti + element.tutar!;
        }
      }
    }

    return tuketilenToplamAkaryakitMaliyeti.toStringAsFixed(2);
  }

  String getToplamMaliyet() {
    double toplamMaliyet = 0;

    if (listYakitIslemModel.isNotEmpty) {
      for (var element in listYakitIslemModel) {
        if (element!.tutar != null) {
          toplamMaliyet = toplamMaliyet + element.tutar!;
        }
      }
    }

    return toplamMaliyet.toStringAsFixed(2);
  }

  String getToplamKm() {
    double toplamKm = 0;
    if (listYakitIslemModel.isNotEmpty) {
      if (listYakitIslemModel.last!.aracKm != null &&
          listYakitIslemModel.first!.aracKm != null) {
        toplamKm = (listYakitIslemModel.last!.aracKm!) -
            (listYakitIslemModel.first!.aracKm!);
      }
    }

    return toplamKm.toStringAsFixed(2);
  }

  String getTlKm() {
    double tlKm = 0;

    tlKm = (double.tryParse(getToplamMaliyet()))! /
        (double.tryParse(getToplamKm()))!;

    return tlKm.toStringAsFixed(2);
  }

  String getTlKmLpg() {
    return (double.tryParse(getToplamLpgMaliyeti())! /
            double.tryParse(getToplamKm())!)
        .toStringAsFixed(2);
  }

  String getTlKmAkaryakit() {
    return (double.tryParse(getToplamAkaryakitMaliyeti())! /
            double.tryParse(getToplamKm())!)
        .toStringAsFixed(2);
  }

  String getLitreKmLpg() {
    return (double.tryParse(getToplamLpgMiktari())! *
            100 /
            double.tryParse(getToplamKm())!)
        .toStringAsFixed(2);
  }

  String getLitreKmAkaryakit() {
    return (double.tryParse(getToplamAkaryakitMiktari())! *
            100 /
            double.tryParse(getToplamKm())!)
        .toStringAsFixed(2);
  }

  String getSonKm() {
    double? sonKm = 0;

    sonKm =
        listYakitIslemModel.isNotEmpty ? listYakitIslemModel.last!.aracKm : 0;

    return sonKm.toString();
  }

  List<YakitIslemModel?> getListYakitIslemModelLpg() {
    return ((listYakitIslemModel
        .where((element) => element!.yakitTuru == YakitTuruEnum.LPG)).toList());
  }

  List<YakitIslemModel?> getListYakitIslemModelAkaryakit() {
    var result = (listYakitIslemModel
        .where((element) => element!.yakitTuru != YakitTuruEnum.LPG)).toList();

    return result;
  }

  String getOrtalamLpgMaliyet() {
    return (double.tryParse(getToplamLpgMaliyeti())! /
            double.tryParse(getToplamLpgMiktari())!)
        .toStringAsFixed(2);
  }

  String getOrtalamaAkaryakitMaliyeti() {
    return (double.tryParse(getToplamAkaryakitMaliyeti())! /
            double.tryParse(getToplamAkaryakitMiktari())!)
        .toStringAsFixed(2);
  }
}

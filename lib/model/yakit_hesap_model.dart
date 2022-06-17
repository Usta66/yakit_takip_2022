import 'package:kartal/kartal.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

import '../enum/yakit_turu_enum.dart';
import 'car_model.dart';
import 'yakit_islem_model.dart';

class YakitHesapModel {
  final List<YakitIslemModel?> listYakitIslemModel;
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
  late String toplamKmLpg;
  late String toplamKmAkaryakit;

  YakitHesapModel({required this.carModel, required this.listYakitIslemModel}) {
    init();
  }

  Future<void> init() async {
    //listYakitIslemModel = await DatabaseService.instance!.getAracYakitListesi(aracId: carModel.id!);

    toplamLpgMiktari = getToplamLpgMiktari();
    toplamLpgMaliyeti = getToplamLpgMaliyeti();
    sonKm = getSonKm();

    toplamAkaryakitMiktari = getToplamAkaryakitMiktari();
    toplamAkaryakitMaliyeti = getToplamAkaryakitMaliyeti();
    toplamMaliyet = getToplamMaliyet();
    toplamKm = getToplamKm();
    tLKm = getTlKm();

    listYakitIslemModelLpg = getListYakitIslemModelLpg();
    listYakitIslemModelAkaryakit = getListYakitIslemModelAkaryakit();

    listYakitIslemModel.sort((a, b) => a!.aracKm!.compareTo(b!.aracKm!));

    listYakitIslemModelLpg.sort((a, b) => a!.aracKm!.compareTo(b!.aracKm!));
    listYakitIslemModelAkaryakit.sort((a, b) => a!.aracKm!.compareTo(b!.aracKm!));
    ortalamaLpgMaliyeti = getOrtalamLpgMaliyet();
    ortalamaAkaryakitMaliyeti = getOrtalamaAkaryakitMaliyeti();

    mesafeHesapla();

    toplamKmLpg = getToplamKmLpg();
    toplamKmAkaryakit = getToplamKmAkaryakit();

    tLKmLpg = getTlKmLpg();
    tlKmAkaryakit = getTlKmAkaryakit();
    litreKmLpg = getLitreKmLpg();
    litreKmAkaryakit = getLitreKmAkaryakit();
  }

  static Future<List<YakitIslemModel?>> getListYakitislemModel(CarModel carModel) async {
    return await DatabaseService.instance!.getAracYakitListesi(aracId: carModel.id!);
  }

  String getToplamLpgMiktari() {
    double tuketilenLpgMiktari = 0;

    if (listYakitIslemModel.isNotEmpty && carModel.yakitTuru == YakitTuruEnum.LPG) {
      var result = listYakitIslemModel.where((element) => element!.yakitTuru == YakitTuruEnum.LPG);

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

    if (listYakitIslemModel.isNotEmpty && carModel.yakitTuru == YakitTuruEnum.LPG) {
      var result = listYakitIslemModel.where((element) => element!.yakitTuru == YakitTuruEnum.LPG);

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
      var result = listYakitIslemModel.where((element) => element!.yakitTuru != YakitTuruEnum.LPG);

      for (var element in result) {
        if (element!.miktari != null) {
          tuketilenToplamAkaryakitMiktari = tuketilenToplamAkaryakitMiktari + element.miktari!;
        }
      }
    }

    return tuketilenToplamAkaryakitMiktari.toStringAsFixed(2);
  }

  String getToplamAkaryakitMaliyeti() {
    double tuketilenToplamAkaryakitMaliyeti = 0;

    if (listYakitIslemModel.isNotEmpty) {
      var result = listYakitIslemModel.where((element) => element!.yakitTuru != YakitTuruEnum.LPG);

      for (var element in result) {
        if (element!.tutar != null) {
          tuketilenToplamAkaryakitMaliyeti = tuketilenToplamAkaryakitMaliyeti + element.tutar!;
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
      if (listYakitIslemModel.last!.aracKm != null && listYakitIslemModel.first!.aracKm != null) {
        toplamKm = (listYakitIslemModel.last!.aracKm!) - (listYakitIslemModel.first!.aracKm!);
      }
    }

    return toplamKm.toStringAsFixed(2);
  }

  getToplamKmLpg() {
    double toplamKm = 0;
    if (!listYakitIslemModelLpg.isNullOrEmpty) {
      if (listYakitIslemModelLpg.last!.aracKm != null && listYakitIslemModelLpg.first!.aracKm != null) {
        toplamKm = (listYakitIslemModelLpg.last!.aracKm!) - (listYakitIslemModelLpg.first!.aracKm!);
      }
    }

    return toplamKm.toStringAsFixed(2);
  }

  getToplamKmAkaryakit() {
    double toplamKm = 0;
    if (!listYakitIslemModelAkaryakit.isNullOrEmpty) {
      if (listYakitIslemModelAkaryakit.last!.aracKm != null && listYakitIslemModelAkaryakit.first!.aracKm != null) {
        toplamKm = (listYakitIslemModelAkaryakit.last!.aracKm!) - (listYakitIslemModelAkaryakit.first!.aracKm!);
      }
    }

    return toplamKm.toStringAsFixed(2);
  }

  String getTlKm() {
    double tlKm = 0;

    tlKm = (double.tryParse(getToplamMaliyet()))! / (double.tryParse(getToplamKm()))!;

    return tlKm.toStringAsFixed(2);
  }

  String getTlKmLpg() {
    return (double.tryParse(getToplamLpgMaliyeti())! / double.tryParse(getToplamKmLpg())!).toStringAsFixed(2);
  }

  String getTlKmAkaryakit() {
    return (double.tryParse(getToplamAkaryakitMaliyeti())! / double.tryParse(getToplamKmAkaryakit())!).toStringAsFixed(2);
  }

  String getLitreKmLpg() {
    return (double.tryParse(getToplamLpgMiktari())! * 100 / double.tryParse(getToplamKmLpg())!).toStringAsFixed(2);
  }

  String getLitreKmAkaryakit() {
    return (double.tryParse(getToplamAkaryakitMiktari())! * 100 / double.tryParse(getToplamKmAkaryakit())!).toStringAsFixed(2);
  }

  String getSonKm() {
    double? sonKm = 0;

    sonKm = listYakitIslemModel.isNotEmpty ? listYakitIslemModel.last!.aracKm : 0;

    return sonKm.toString();
  }

  List<YakitIslemModel?> getListYakitIslemModelLpg() {
    return ((listYakitIslemModel.where((element) => element!.yakitTuru == YakitTuruEnum.LPG)).toList());
  }

  List<YakitIslemModel?> getListYakitIslemModelAkaryakit() {
    var result = (listYakitIslemModel.where((element) => element!.yakitTuru != YakitTuruEnum.LPG)).toList();

    return result;
  }

  String getOrtalamLpgMaliyet() {
    return (double.tryParse(getToplamLpgMaliyeti())! / double.tryParse(getToplamLpgMiktari())!).toStringAsFixed(2);
  }

  String getOrtalamaAkaryakitMaliyeti() {
    return (double.tryParse(getToplamAkaryakitMaliyeti())! / double.tryParse(getToplamAkaryakitMiktari())!).toStringAsFixed(2);
  }

  mesafeHesapla() {
    if (listYakitIslemModelLpg.length >= 2) {
      for (var i = 0; i < listYakitIslemModelLpg.length; i++) {
        if (listYakitIslemModelLpg.length >= i + 2) {
          listYakitIslemModelLpg[i]!.mesafe = listYakitIslemModelLpg[i + 1]!.aracKm! - listYakitIslemModelLpg[i]!.aracKm!;
        }
      }
    }

    if (listYakitIslemModelAkaryakit.length >= 2) {
      for (var i = 0; i < listYakitIslemModelAkaryakit.length; i++) {
        if (listYakitIslemModelAkaryakit.length >= i + 2) {
          listYakitIslemModelAkaryakit[i]!.mesafe = listYakitIslemModelAkaryakit[i + 1]!.aracKm! - listYakitIslemModelAkaryakit[i]!.aracKm!;
        }
      }
    }

    listYakitIslemModel.clear();

    listYakitIslemModel.addAll(listYakitIslemModelLpg);
    listYakitIslemModel.addAll(listYakitIslemModelAkaryakit);

    listYakitIslemModel.sort((a, b) => a!.aracKm!.compareTo(b!.aracKm!));
  }
}

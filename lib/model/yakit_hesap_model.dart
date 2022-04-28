import '../enum/yakit_turu_enum.dart';
import 'car_model.dart';
import 'yakit_islem_model.dart';

class YakitHesapModel {
  final List<YakitIslemModel?> listYakitIslemModel;
  final CarModel carModel;
  double toplamLpgMiktari = 1;
  double toplamLpgMaliyeti = 1;
  double toplamAkaryakitMiktari = 1;
  double toplamAkaryakitMaliyeti = 1;
  double toplamMaliyet = 1;
  double toplamKm = 1;
  double tLKm = 1;
  double tLKmLpg = 1;
  double tlKmAkaryakit = 1;
  double litreKmLpg = 1;
  double litreKmAkaryakit = 1;

  YakitHesapModel({required this.listYakitIslemModel, required this.carModel}) {
    if (carModel.yakitTuru == YakitTuruEnum.LPG) {
      toplamLpgMiktari = getToplamLpgMiktari();
      toplamLpgMaliyeti = getToplamLpgMaliyeti();
    }

    toplamAkaryakitMiktari = getToplamAkaryakitMiktari();
    toplamAkaryakitMaliyeti = getToplamAkaryakitMaliyeti();
    toplamMaliyet = getToplamMaliyet();
    toplamKm = getToplamKm();
    tLKm = getTlKm();
    tLKmLpg = getTlKmLpg();
    tlKmAkaryakit = getTlKmAkaryakit();
    litreKmLpg = getLitreKmLpg();
    litreKmAkaryakit = getLitreKmAkaryakit();
  }

  double getToplamLpgMiktari() {
    double tuketilenLpgMiktari = 0;

    if (listYakitIslemModel.isNotEmpty) {
      var result = listYakitIslemModel.where((element) => element!.yakitTuru == YakitTuruEnum.LPG);

      for (var element in result) {
        if (element!.miktari != null) {
          tuketilenLpgMiktari = tuketilenLpgMiktari + element.miktari!;
        }
      }
    }

    return tuketilenLpgMiktari;
  }

  double getToplamLpgMaliyeti() {
    double tuketilenLpgMaliyeti = 0;

    if (listYakitIslemModel.isNotEmpty) {
      var result = listYakitIslemModel.where((element) => element!.yakitTuru == YakitTuruEnum.LPG);

      for (var element in result) {
        if (element!.tutar != null) {
          tuketilenLpgMaliyeti = tuketilenLpgMaliyeti + element.tutar!;
        }
      }
    }

    return tuketilenLpgMaliyeti;
  }

  double getToplamAkaryakitMiktari() {
    double tuketilenToplamAkaryakitMiktari = 0;

    if (listYakitIslemModel.isNotEmpty) {
      var result = listYakitIslemModel.where((element) => element!.yakitTuru != YakitTuruEnum.LPG);

      for (var element in result) {
        if (element!.miktari != null) {
          tuketilenToplamAkaryakitMiktari = tuketilenToplamAkaryakitMiktari + element.miktari!;
        }
      }
    }

    return tuketilenToplamAkaryakitMiktari;
  }

  double getToplamAkaryakitMaliyeti() {
    double tuketilenToplamAkaryakitMaliyeti = 0;

    if (listYakitIslemModel.isNotEmpty) {
      var result = listYakitIslemModel.where((element) => element!.yakitTuru != YakitTuruEnum.LPG);

      for (var element in result) {
        if (element!.tutar != null) {
          tuketilenToplamAkaryakitMaliyeti = tuketilenToplamAkaryakitMaliyeti + element.tutar!;
        }
      }
    }

    return tuketilenToplamAkaryakitMaliyeti;
  }

  double getToplamMaliyet() {
    double toplamMaliyet = 0;

    if (listYakitIslemModel.isNotEmpty) {
      for (var element in listYakitIslemModel) {
        if (element!.tutar != null) {
          toplamMaliyet = toplamMaliyet + element.tutar!;
        }
      }
    }

    return toplamMaliyet;
  }

  getToplamKm() {
    double toplamKm = 0;
    if (listYakitIslemModel.isNotEmpty) {
      if (listYakitIslemModel.last!.aracKm != null && listYakitIslemModel.first!.aracKm != null) {
        toplamKm = (listYakitIslemModel.last!.aracKm!) - (listYakitIslemModel.first!.aracKm!);
      }
    }

    return toplamKm;
  }

  double getTlKm() {
    return getToplamMaliyet() / getToplamKm();
  }

  double getTlKmLpg() {
    return getToplamLpgMaliyeti() / getToplamKm();
  }

  double getTlKmAkaryakit() {
    return getToplamAkaryakitMaliyeti() / getToplamKm();
  }

  double getLitreKmLpg() {
    return getToplamLpgMiktari() / getToplamKm();
  }

  getLitreKmAkaryakit() {
    return getToplamAkaryakitMiktari() / getToplamKm();
  }
}

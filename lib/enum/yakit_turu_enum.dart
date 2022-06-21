// ignore_for_file: constant_identifier_names

enum YakitTuruEnum { BENZIN, LPG, DIZEL, ELEKTIRIK }

extension YakitTuruExtension on String {
  // ignore: non_constant_identifier_names
  YakitTuruEnum? get YakitTuruValu {
    switch (this) {
      case "BENZIN":
        return YakitTuruEnum.BENZIN;
      case "GASOLINE":
        return YakitTuruEnum.BENZIN;
      case "LPG":
        return YakitTuruEnum.LPG;
      case "DIZEL":
        return YakitTuruEnum.DIZEL;
      case "DIESEL":
        return YakitTuruEnum.DIZEL;
      case "ELEKTIRIK":
        return YakitTuruEnum.ELEKTIRIK;

      default:
        throw ("Yakit Turunde Hata Var");
    }
  }
}

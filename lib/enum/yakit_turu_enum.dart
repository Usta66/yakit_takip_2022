enum YakitTuruEnum { BENZIN, LPG, DIZEL, ELEKTIRIK }

extension YakitTuruExtension on String {
  YakitTuruEnum? get YakitTuruValu {
    switch (this) {
      case "BENZIN":
        return YakitTuruEnum.BENZIN;
      case "LPG":
        return YakitTuruEnum.LPG;
      case "DIZEL":
        return YakitTuruEnum.DIZEL;
      case "ELEKTIRIK":
        return YakitTuruEnum.ELEKTIRIK;

      default:
        throw ("Yakit Turunde Hata Var");
    }
  }
}
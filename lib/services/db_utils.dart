import 'package:yakit_takip_2022/model/base_model.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';

class DbUtils {
  String getTableName<T extends BaseModel>() {
    switch (T) {
      case CarModel:
        return EnumTableName.araclarTablosu.name;

      case YakitIslemModel:
        return EnumTableName.yakitIslemTablosu.name;

      default:
        throw Exception("$T değer dışı yada girilmedi dbUtils getTableName metoduna bak!!!!!!!!");
    }
  }

  // ignore: avoid_shadowing_type_parameters
  T? fromMap<T extends BaseModel>(Map<String, Object?>? map) {
    if (map == null) {
      return null;
    } else if (T == CarModel) {
      return CarModel.fromMap(map) as T;
    } else if (T == YakitIslemModel) {
      return YakitIslemModel.fromMap(map) as T;
    } else {
      throw Exception("Mapper'da $T Hatası DBUtils Mapper'i Kontrol Et");
    }
  }
}

enum EnumTableName { araclarTablosu, yakitIslemTablosu }
enum EnumDbName { db }

enum EnumAraclarTablosuColumnName {
  id,
  adi,
  yakitTuru,
  imagePath,
  aracKm,
  ortalamaLitre,
  ortalamaKrs,
  aracLpgDepo,
  aracDepo,
  mevcutLpgMiktari,
  mevcutYakitMiktari
}

enum EnumYakitIslemTablosuColumnName { id, aracId, alisTarihi, alisSaati, fiyati, miktari, tutar, aracKm, mesafe }

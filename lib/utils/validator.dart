import 'package:yakit_takip_2022/utils/string_extantion.dart';

mixin Validator {
  String? bosOlamaz(String value) {
    if (value != null) {
      return (value.trim().isNullOrEmpty) ? "Boş Olmamalı" : null;
    } else {
      return value.isNullOrEmpty ? "Boş Olmamalı" : null;
    }
  }

  String? kucukOlamaz(String value, double sonKm) {
    if (double.parse(value) <= sonKm) {
      return "Son Km'den Küçük Olamaz";
    } else {
      return null;
    }
  }

  String? kmKontrol(String deger, double? birOnceki, double? birSonraki) {
    print("birOnceki");
    print(birOnceki);
    print("birSonraki");
    print(birSonraki);

    if (birOnceki != null) {
      if (birOnceki < double.parse(deger)) {
        if (birSonraki != null) {
          if (birSonraki > double.parse(deger)) {
            return null;
          } else {
            return "Büyük Km";
          }
        }
      } else {
        return "Kücük Km";
      }
    } else {
      if (birSonraki != null) {
        if (birSonraki > double.parse(deger)) {
          return null;
        } else {
          return "Büyük Km";
        }
      }
    }
  }
}

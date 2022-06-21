import 'package:easy_localization/easy_localization.dart';
import 'package:yakit_takip_2022/utils/extantion.dart';

import 'locale_keys.g.dart';

mixin Validator {
  String? bosOlamaz(String? value) {
    if (value != null) {
      return (value.trim().isNullOrEmpty) ? LocaleKeys.validator_bosOlamaz.tr() : null;
    }
    return null;
  }

  String? kucukOlamaz(String value, double sonKm) {
    if (double.parse(value) <= sonKm) {
      return LocaleKeys.validator_sonKmKucukOlamaz.tr();
    } else {
      return null;
    }
  }

  String? kmKontrol(String deger, double? birOnceki, double? birSonraki) {
    if (birOnceki != null) {
      if (birOnceki < double.parse(deger)) {
        if (birSonraki != null) {
          if (birSonraki > double.parse(deger)) {
            return null;
          } else {
            return LocaleKeys.validator_birsonrakindenBuyukKm.tr();
          }
        }
      } else {
        return LocaleKeys.validator_birOncekindenKucukKm.tr();
      }
    } else {
      if (birSonraki != null) {
        if (birSonraki > double.parse(deger)) {
          return null;
        } else {
          return LocaleKeys.validator_birsonrakindenBuyukKm.tr();
        }
      }
    }
    return null;
  }
}

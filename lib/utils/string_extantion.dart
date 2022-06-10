import 'package:easy_localization/easy_localization.dart';

extension StringExtantion on String {
  String get locale => this.tr();

  String binlikAyracFormat() {
    var formatter = NumberFormat.decimalPattern(",");
    return formatter.format(this);
  }

  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    } else {
      if (this == "") {
        return true;
      } else {
        return false;
      }
    }
  }
}

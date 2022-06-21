import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

DateFormat _onlyDateFormater = DateFormat('dd/MM/yyyy');
// ignore: unused_element
DateFormat _fullDateFormatter = DateFormat('dd/MM/yyyy  HH:mm');
DateFormat _onlyTimeFormatter = DateFormat('HH:mm');

extension DateTimeStringFormat on DateTime {
  String get stringValue {
    return _onlyDateFormater.format(this);
  }

  String get timeToString {
    return _onlyTimeFormatter.format(this);
  }
}

extension StringFromDateTime on String {
  DateTime get stringToDateTime {
    return _onlyDateFormater.parse(this);
  }

  DateTime get stringToDayOfTime {
    return _onlyTimeFormatter.parse(this);
  }

  TimeOfDay get stringFromTimeOfDay {
    return TimeOfDay.fromDateTime(stringToDayOfTime);
  }
}

extension TimeOfDayToString on TimeOfDay {
  String get stringValue {
    MaterialLocalizations _localizations = const DefaultMaterialLocalizations();
    return _localizations.formatTimeOfDay(this, alwaysUse24HourFormat: true);
  }
}

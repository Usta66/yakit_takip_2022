import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:yakit_takip_2022/model/base_model.dart';
import 'package:yakit_takip_2022/utils/date_time_extension.dart';

class YakitIslemModel implements BaseModel {
  @override
  int? id;
  int? aracId;
  String? yakitTuru;
  DateTime? alisTarihi;
  TimeOfDay? alisSaati;

  double? fiyati;
  double? miktari;
  double? tutar;
  double? aracKm;
  double? mesafe;
  YakitIslemModel({
    this.id,
    this.aracId,
    this.yakitTuru,
    this.alisTarihi,
    this.alisSaati,
    this.fiyati,
    this.miktari,
    this.tutar,
    this.aracKm,
    this.mesafe,
  });

  @override
  YakitIslemModel fromMap(Map<String, dynamic> map) {
    return YakitIslemModel.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'aracId': aracId,
      'yakitTuru': yakitTuru,
      'alisTarihi': alisTarihi?.stringValue,
      'alisSaati': alisSaati?.stringValue,
      'fiyati': fiyati,
      'miktari': miktari,
      'tutar': tutar,
      'aracKm': aracKm,
      'mesafe': mesafe,
    };
  }

  YakitIslemModel copyWith({
    int? id,
    int? aracId,
    String? yakitTuru,
    DateTime? alisTarihi,
    TimeOfDay? alisSaati,
    double? fiyati,
    double? miktari,
    double? tutar,
    double? aracKm,
    double? mesafe,
  }) {
    return YakitIslemModel(
      id: id ?? this.id,
      aracId: aracId ?? this.aracId,
      yakitTuru: yakitTuru ?? this.yakitTuru,
      alisTarihi: alisTarihi ?? this.alisTarihi,
      alisSaati: alisSaati ?? this.alisSaati,
      fiyati: fiyati ?? this.fiyati,
      miktari: miktari ?? this.miktari,
      tutar: tutar ?? this.tutar,
      aracKm: aracKm ?? this.aracKm,
      mesafe: mesafe ?? this.mesafe,
    );
  }

  factory YakitIslemModel.fromMap(Map<String, dynamic> map) {
    return YakitIslemModel(
      id: map['id']?.toInt(),
      aracId: map['aracId']?.toInt(),
      yakitTuru: map['yakitTuru'],
      alisTarihi: (map['alisTarihi'] as String).stringToDateTime,
      alisSaati: (map['alisSaati'] as String).stringFromTimeOfDay,
      fiyati: map['fiyati']?.toDouble(),
      miktari: map['miktari']?.toDouble(),
      tutar: map['tutar']?.toDouble(),
      aracKm: map['aracKm']?.toDouble(),
      mesafe: map['mesafe']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory YakitIslemModel.fromJson(String source) => YakitIslemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'YakitIslemModel(id: $id, aracId: $aracId, yakitTuru: $yakitTuru, alisTarihi: $alisTarihi, alisSaati: $alisSaati, fiyati: $fiyati, miktari: $miktari, tutar: $tutar, aracKm: $aracKm, mesafe: $mesafe)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YakitIslemModel &&
        other.id == id &&
        other.aracId == aracId &&
        other.yakitTuru == yakitTuru &&
        other.alisTarihi == alisTarihi &&
        other.alisSaati == alisSaati &&
        other.fiyati == fiyati &&
        other.miktari == miktari &&
        other.tutar == tutar &&
        other.aracKm == aracKm &&
        other.mesafe == mesafe;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        aracId.hashCode ^
        yakitTuru.hashCode ^
        alisTarihi.hashCode ^
        alisSaati.hashCode ^
        fiyati.hashCode ^
        miktari.hashCode ^
        tutar.hashCode ^
        aracKm.hashCode ^
        mesafe.hashCode;
  }
}

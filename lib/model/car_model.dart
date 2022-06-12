import 'dart:convert';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';
import 'package:yakit_takip_2022/model/base_model.dart';

class CarModel implements BaseModel {
  @override
  int? id;

  String? adi;
  YakitTuruEnum? yakitTuru;
  String? imagePath;
  double? aracKm;
  num? ortalamaLitre;
  num? ortalamaTl;
  double? aracLpgDepo;
  double? aracDepo;
  double? mevcutLpgMiktari;
  double? mevcutYakitMiktari;
  int? color;
  CarModel(
      {this.id,
      this.adi,
      this.yakitTuru,
      this.imagePath,
      this.aracKm,
      this.ortalamaLitre,
      this.ortalamaTl,
      this.aracLpgDepo,
      this.aracDepo,
      this.mevcutLpgMiktari,
      this.mevcutYakitMiktari,
      this.color});

  @override
  CarModel fromMap(Map<String, dynamic> map) {
    return CarModel.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adi': adi,
      'yakitTuru': yakitTuru!.name,
      'imagePath': imagePath,
      'aracKm': aracKm,
      'ortalamaLitre': ortalamaLitre,
      'ortalamaKrs': ortalamaTl,
      'aracLpgDepo': aracLpgDepo,
      'aracDepo': aracDepo,
      'mevcutLpgMiktari': mevcutLpgMiktari,
      'mevcutYakitMiktari': mevcutYakitMiktari,
      'color': color
    };
  }

  CarModel copyWith(
      {int? id,
      String? adi,
      YakitTuruEnum? yakitTuru,
      String? imagePath,
      double? aracKm,
      num? ortalamaLitre,
      num? ortalamaKrs,
      double? aracLpgDepo,
      double? aracDepo,
      double? mevcutLpgMiktari,
      double? mevcutYakitMiktari,
      int? color}) {
    return CarModel(
        id: id ?? this.id,
        adi: adi ?? this.adi,
        yakitTuru: yakitTuru ?? this.yakitTuru,
        imagePath: imagePath ?? this.imagePath,
        aracKm: aracKm ?? this.aracKm,
        ortalamaLitre: ortalamaLitre ?? this.ortalamaLitre,
        ortalamaTl: ortalamaKrs ?? this.ortalamaTl,
        aracLpgDepo: aracLpgDepo ?? this.aracLpgDepo,
        aracDepo: aracDepo ?? this.aracDepo,
        mevcutLpgMiktari: mevcutLpgMiktari ?? this.mevcutLpgMiktari,
        mevcutYakitMiktari: mevcutYakitMiktari ?? this.mevcutYakitMiktari,
        color: color ?? this.color);
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
        id: map['id']?.toInt(),
        adi: map['adi'],
        yakitTuru: map['yakitTuru'] != null
            ? ((map['yakitTuru'] as String).YakitTuruValu)
            : null,
        imagePath: map['imagePath'],
        aracKm: map['aracKm']?.toDouble(),
        ortalamaLitre: map['ortalamaLitre'],
        ortalamaTl: map['ortalamaKrs'],
        aracLpgDepo: map['aracLpgDepo']?.toDouble(),
        aracDepo: map['aracDepo']?.toDouble(),
        mevcutLpgMiktari: map['mevcutLpgMiktari']?.toDouble(),
        mevcutYakitMiktari: map['mevcutYakitMiktari']?.toDouble(),
        color: map['color']);
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) =>
      CarModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CarModel(id: $id, adi: $adi, yakitTuru: $yakitTuru, imagePath: $imagePath, aracKm: $aracKm, ortalamaLitre: $ortalamaLitre, ortalamaKrs: $ortalamaTl, aracLpgDepo: $aracLpgDepo, aracDepo: $aracDepo, mevcutLpgMiktari: $mevcutLpgMiktari, mevcutYakitMiktari: $mevcutYakitMiktari,color:$color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarModel &&
        other.id == id &&
        other.adi == adi &&
        other.yakitTuru == yakitTuru &&
        other.imagePath == imagePath &&
        other.aracKm == aracKm &&
        other.ortalamaLitre == ortalamaLitre &&
        other.ortalamaTl == ortalamaTl &&
        other.aracLpgDepo == aracLpgDepo &&
        other.aracDepo == aracDepo &&
        other.mevcutLpgMiktari == mevcutLpgMiktari &&
        other.mevcutYakitMiktari == mevcutYakitMiktari &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        adi.hashCode ^
        yakitTuru.hashCode ^
        imagePath.hashCode ^
        aracKm.hashCode ^
        ortalamaLitre.hashCode ^
        ortalamaTl.hashCode ^
        aracLpgDepo.hashCode ^
        aracDepo.hashCode ^
        mevcutLpgMiktari.hashCode ^
        mevcutYakitMiktari.hashCode ^
        color.hashCode;
  }
}

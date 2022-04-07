import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/services/Idatabase_service.dart';
import 'package:yakit_takip_2022/services/db_utils.dart';

import '../model/base_model.dart';

class DatabaseService extends IDatabaseService {
  static DatabaseService? _instance;

  final int _version = 02;
  Database? _db;

  static DatabaseService? get instance {
    _instance ??= DatabaseService._init();

    return _instance;
  }

  DatabaseService._init();

  DbUtils dbUtils = DbUtils();

  Future<Database> get db async {
    
    _db??=  await dbOpen();
    

    return _db!;
  }

  Future<Database> dbOpen() async {
    try {
      String path = join(await getDatabasesPath(), EnumDbName.db.name);

      return await openDatabase(path,
          version: _version, onCreate: _createDb, onConfigure: _onConfigure);
    } on Exception catch (e) {
    

      throw ("Database Açılmadı Hata");
    }
  }

  FutureOr<void> _createDb(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE ${EnumTableName.araclarTablosu.name}(${EnumAraclarTablosuColumnName.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${EnumAraclarTablosuColumnName.adi.name} VARCHAR(20),
    ${EnumAraclarTablosuColumnName.yakitTuru.name} VARCHAR(20),
    ${EnumAraclarTablosuColumnName.imagePath.name} TEXT,
    ${EnumAraclarTablosuColumnName.aracKm.name} DOUBLE,
    ${EnumAraclarTablosuColumnName.ortalamaLitre.name} DOUBLE,
    ${EnumAraclarTablosuColumnName.ortalamaKrs.name} DOUBLE,
    ${EnumAraclarTablosuColumnName.aracLpgDepo.name} DOUBLE,
    ${EnumAraclarTablosuColumnName.aracDepo.name} DOUBLE,
    ${EnumAraclarTablosuColumnName.mevcutLpgMiktari.name} DOUBLE,
    ${EnumAraclarTablosuColumnName.mevcutYakitMiktari.name} DOUBLE

    )    ''');

    await db.execute('''CREATE TABLE
    ${EnumTableName.yakitIslemTablosu.name} 
    (${EnumYakitIslemTablosuColumnName.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${EnumYakitIslemTablosuColumnName.aracId.name} INTEGER,
    ${EnumYakitIslemTablosuColumnName.alisTarihi.name} VARCHAR(20),
    ${EnumYakitIslemTablosuColumnName.alisSaati.name} VARCHAR(20),
    ${EnumYakitIslemTablosuColumnName.fiyati.name} DOUBLE,
    ${EnumYakitIslemTablosuColumnName.miktari.name} DOUBLE,
    ${EnumYakitIslemTablosuColumnName.aracKm.name} DOUBLE,
    ${EnumYakitIslemTablosuColumnName.tutar.name} DOUBLE,
    ${EnumYakitIslemTablosuColumnName.mesafe.name} DOUBLE,
    FOREIGN KEY(${EnumYakitIslemTablosuColumnName.aracId.name}) REFERENCES ${EnumTableName.araclarTablosu.name}(${EnumAraclarTablosuColumnName.id.name})

    ) ''');
  }

  FutureOr<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  @override
  Future<int> insert<T extends BaseModel>(T model) async {
    if (_db != null) {
      return await _db!.insert(dbUtils.getTableName<T>(), model.toMap());
    } else {
      throw ("insert hata!!!! model eklenemedi Database null");
    }
  }

  @override
  Future<int> delete<T extends BaseModel>(int id) async {
    if (_db != null) {
      return await (_db!.delete(dbUtils.getTableName<T>(),
          where: "${EnumAraclarTablosuColumnName.id.name}=?", whereArgs: [id]));
    } else {
      throw ("delete hata");
    }
  }

  @override
  Future<T?> getModel<T extends BaseModel>(int id) async {
    if (_db != null) {
      Map<String, Object?> modelMaps = (await _db!.query(
              dbUtils.getTableName<T>(),
              where: "${EnumAraclarTablosuColumnName.id.name}=?",
              whereArgs: [id]))
          .first;

      return dbUtils.fromMap<T>(modelMaps);
    } else {
      throw ("getModel model cekilemedi db null");
    }
  }

  @override
  Future<List<T?>> getModelList<T extends BaseModel>() async {
    Database dataBase = await db;
    List<Map<String, dynamic>> modelMaps =
        await dataBase.query(dbUtils.getTableName<T>());

    return modelMaps.map((e) => dbUtils.fromMap<T>(e)).toList();
  }

  @override
  Future<int> update<T extends BaseModel>(T model) async {
    if (_db != null) {
      return await (_db!.update(dbUtils.getTableName<T>(), model.toMap(),
          where: "${EnumAraclarTablosuColumnName.id.name}=?",
          whereArgs: [model.id]));
    } else {
      throw ("update hata");
    }
  }

  @override
  Future<int> aracaAitTumYakitlariSil(int id) async {
    if (_db != null) {
      return await _db!.delete(
        dbUtils.getTableName<YakitIslemModel>(),
        where: "${EnumAraclarTablosuColumnName.id.name}=?",
        whereArgs: [id],
      );
    } else {
      throw ("Araca ait yakıtlar silinirken hata!!!!!!");
    }
  }

  @override
  close() {
    if (_db != null) {
      _db!.close();
    } else {
      throw ("close db null");
    }
  }
}

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
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

  DatabaseService._init() {
    print("db init çalıştı");
    db;
  }

  DbUtils dbUtils = DbUtils();

  Database? get db {
    if (_db == null) {
      dbOpen().then((value) {
        _db = value;
      });
    }

    return _db;
  }

  Future<Database> dbOpen() async {
    late Database myDb;
    try {
      String path = join(await getDatabasesPath(), EnumDbName.db.name);

      myDb = await openDatabase(path, version: _version, onCreate: _createDb, onConfigure: _onConfigure);

      print("db open");
      return myDb;
    } on Exception catch (e) {
      print(e);
      print("Database açılamadı");

      throw ("Database Açılmadı Hata");
    }
  }

  FutureOr<void> _createDb(Database db, int version) async {
    await db.execute('''CREATE TABLE ${EnumTableName.araclarTablosu.name}(${EnumAraclarTablosuColumnName.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
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
    if (db != null) {
      return await db!.insert(dbUtils.getTableName<T>(), model.toMap());
    } else {
      throw ("insert hata!!!! model eklenemedi Database null");
    }
  }

  @override
  Future<int> delete<T extends BaseModel>(int id) async {
    if (db != null) {
      return await (db!.delete(dbUtils.getTableName<T>(), where: "${EnumAraclarTablosuColumnName.id.name}=?", whereArgs: [id]));
    } else {
      throw ("delete hata");
    }
  }

  @override
  Future<T?> getModel<T extends BaseModel>(int id) async {
    if (db != null) {
      Map<String, Object?> modelMaps =
          (await db!.query(dbUtils.getTableName<T>(), where: "${EnumAraclarTablosuColumnName.id.name}=?", whereArgs: [id])).first;

      return dbUtils.fromMap<T>(modelMaps);
    } else {
      throw ("getModel model cekilemedi db null");
    }
  }

  @override
  Future<List<T?>> getModelList<T extends BaseModel>() async {
    db;
    if (db != null) {
      List<Map<String, dynamic>> modelMaps = await db!.query(dbUtils.getTableName<T>());

      return modelMaps.map((e) => dbUtils.fromMap<T>(e)).toList();
    } else {
      throw ("getModelList model listesi getirilemedi");
    }
  }

  @override
  Future<int> update<T extends BaseModel>(T model) async {
    if (db != null) {
      return await (db!.update(dbUtils.getTableName<T>(), model.toMap(), where: "${EnumAraclarTablosuColumnName.id.name}=?", whereArgs: [model.id]));
    } else {
      throw ("update hata");
    }
  }

  @override
  Future<int> aracaAitTumYakitlariSil(int id) async {
    if (db != null) {
      return await db!.delete(
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
    if (db != null) {
      db!.close();
    } else {
      throw ("close db null");
    }
  }
}

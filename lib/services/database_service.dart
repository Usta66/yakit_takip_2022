import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yakit_takip_2022/services/Idatabase_service.dart';
import 'package:yakit_takip_2022/services/db_utils.dart';

import '../model/base_model.dart';

class DatabaseService extends IDatabaseService {
  static DatabaseService? _instance;

  final int _version = 02;
  late Database _db;

  static DatabaseService? get instance {
    _instance ??= DatabaseService._init();
    return _instance;
  }

  DatabaseService._init();

  DbUtils dbUtils = DbUtils();

  Future<Database> get db async {
    _db = await dbOpen();

    return _db;
  }

  Future<Database> dbOpen() async {
    String path = join(await getDatabasesPath(), EnumDbName.db.name);

    Database myDb = await openDatabase(path, version: _version, onCreate: _createDb, onConfigure: _onConfigure);
    return myDb;
  }

  _createDb(Database db, int version) async {
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

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  @override
  Future<int> insert<T extends BaseModel>(T model) async {
    //Database? db = await this.db;

    return (await db).insert(dbUtils.getTableName<T>(), model.toMap());
  }

  getItem<T extends BaseModel>(Database db) {}

  @override
  Future<int> delete<T extends BaseModel>(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<T?> getModel<T extends BaseModel>(int id) async {
    Map<String, Object?> modelMaps =
        (await (await db).query(dbUtils.getTableName<T>(), where: "${EnumAraclarTablosuColumnName.id.name}=?", whereArgs: [id])).first;

    return dbUtils.fromMap<T>(modelMaps);
  }

  @override
  Future<List<T?>> getModelList<T extends BaseModel>() async {
    List<Map<String, dynamic>> modelMaps = await (await db).query(dbUtils.getTableName<T>());

    return modelMaps.map((e) => dbUtils.fromMap<T>(e)).toList();
  }

  @override
  Future<int> update<T extends BaseModel>(T model) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<int> aracaAitTumYakitlariSil(int id) {
    // TODO: implement aracaAitTumYakitlariSil
    throw UnimplementedError();
  }

  @override
  colsed() async {
    (await db).close();
  }
}

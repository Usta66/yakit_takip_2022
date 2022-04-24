import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/model/base_model.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';

abstract class IDatabaseService  {
  Future<List<T?>> getModelList<T extends BaseModel>();
  Future<int> insert<T extends BaseModel>(T model);
  Future<T?> getModel<T extends BaseModel>(int id);
  Future<int> update<T extends BaseModel>(T model);
  Future<int> delete<T extends BaseModel>(int id);

  Future<int> aracaAitTumYakitlariSil(int id);

  Future<List<YakitIslemModel?>> getAracYakitListesi({required int aracId});

  close();
}

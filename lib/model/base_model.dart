abstract class BaseModel<T> {
  int? id;

  T fromMap(Map<String, dynamic> map);
  Map<String, Object?> toMap();
}

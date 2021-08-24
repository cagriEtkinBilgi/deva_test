abstract class BaseModel<T>{

  int get outarized;
  set outarized(int value);

  DateTime get resultDate;
  set resultDate (DateTime value);
  T fromJson(String str);
  T fromMap(Map<String,Object> map);

  Map<String,Object> toMap();
  String toJson();

}
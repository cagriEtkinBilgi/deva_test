import 'dart:convert';
import 'package:deva_test/models/base_models/base_model.dart';

class UserModel extends BaseModel{

  int id;
  String name;
  String surname;
  String email;
  String mobilPhone;
  String userImageURL;

  UserModel({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.mobilPhone,
    this.userImageURL,
    this.outarized,
    this.resultDate
  });



  @override
  int outarized;

  @override
  DateTime resultDate;

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, Object> map) =>UserModel(
    id:map["id"],
    name:map["name"],
    email: map["email"],
    mobilPhone: map["mobilPhone"],
    surname: map["surname"],
    userImageURL: map["userImageURL"]
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, Object> toMap() =>{
    "id":id,
    "name":name,
    "email":email,
    "mobilPhone":mobilPhone,
    "surname":surname,
    "userImageURL":userImageURL
  };

}
import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';

class LoginModel extends BaseModel {
  String UserName;
  String Password;
  int out;

  LoginModel({this.UserName, this.Password});

  LoginModel fromJson(str)=> fromMap(json.decode(str));



  Map<String, dynamic> toMap() => {
    "UserName":UserName,
    "Password":Password
  };

  @override
  String toJson()=>json.encode(toMap());

  @override
  LoginModel fromMap(Map<String, dynamic> map)  =>LoginModel(
    UserName: map["UserName"],
    Password: map["Password"],
  );

  @override
  int outarized;

  @override
  DateTime resultDate;




}
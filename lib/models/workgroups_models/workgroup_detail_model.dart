import 'dart:convert';
import 'package:deva_test/models/base_models/base_model.dart';


class WorkGroupDetailModel extends BaseModel {

  int id;
  String name;
  String desc;
  int authorizationStatus;


  WorkGroupDetailModel({this.id,
    this.name,
    this.desc,
    this.authorizationStatus
  });

  @override
  int outarized=0;

  @override
  DateTime resultDate;

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, dynamic> map){
     var detail=new WorkGroupDetailModel(
        id:map["id"],
        desc :map["desc"],
        name : map["name"],
        authorizationStatus:map["authorizationStatus"]
    );
     return detail;
  }



  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap()=> {
    "id":id,
    "name":name,
    "desc":desc,
    "resultDate":resultDate,
    "authorizationStatus":authorizationStatus
  };



}
import 'dart:convert';
import 'package:deva_test/models/base_models/base_model.dart';

class ContactCreateResultModel extends BaseModel{
  @override
  int outarized;

  @override
  DateTime resultDate;

  int id;
  String smsToken;

  ContactCreateResultModel({
    this.id,
    this.smsToken,
    this.outarized,
    this.resultDate,
  });

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, Object> map)=>ContactCreateResultModel(
    id: map["id"],
    smsToken:map["smsToken"],
    outarized: map["outarized"],
    resultDate: map["resultDate"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, Object> toMap() => {
    "id":id,
    "smsToken":smsToken,
    "resultDate":resultDate,
    "outarized":outarized,
  };



}
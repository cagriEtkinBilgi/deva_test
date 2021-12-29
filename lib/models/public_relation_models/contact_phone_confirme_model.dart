import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';

class ContactPhoneConfirmeModel extends BaseModel{
  @override
  int outarized;
  int id;
  String smsToken;

  ContactPhoneConfirmeModel({
    this.id,
    this.smsToken,
    this.outarized,
    this.resultDate,
  });

  @override
  DateTime resultDate;

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, Object> map) =>ContactPhoneConfirmeModel(
    id: map["id"],
    smsToken: map["smsToken"],
    resultDate: map["resultDate"],
    outarized: map["outarized"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, Object> toMap() => {
    "id":id,
    "smsToken":smsToken,
    "outarized":outarized,
    "resultDate":resultDate,
  };

}
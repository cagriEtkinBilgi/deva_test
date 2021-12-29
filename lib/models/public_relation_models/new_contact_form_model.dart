import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';

class NewContactFormModel extends BaseModel{
  @override
  int outarized;
  int id;
  int userStatus;
  String mobilePhone;
  String name;
  String email;
  String surName;
  String identityNumber;
  int providenceId;
  int districtID;
  int neighborhoodID;
  String birthDate;
  int gender;
  int educationState;
  int jobID;


  NewContactFormModel({
    this.id,
    this.name,
    this.outarized,
    this.resultDate,
    this.email,
    this.mobilePhone,
    this.neighborhoodID,
    this.districtID,
    this.providenceId,
    this.identityNumber,
    this.surName,
    this.userStatus,
    this.birthDate,
    this.gender,
    this.educationState,
    this.jobID,
});

  @override
  DateTime resultDate;

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, Object> map)=> NewContactFormModel(
    id: map["id"],
    name: map["name"],
    userStatus: map["userStatus"],
    resultDate: map["resultDate"],
    outarized: map["outarized"],
    mobilePhone: map["mobilePhone"],
    email: map["email"],
    districtID: map["districtID"],
    identityNumber: map["identityNumber"],
    neighborhoodID: map["neighborhoodID"],
    providenceId: map["providenceId"],
    surName: map["surName"],
    gender: map["gender"],
    birthDate: map["birthDate"],
    educationState: map["educationState"],
    jobID: map["jobID"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, Object> toMap()=>{
    "id":id,
    "surName":surName,
    "identityNumber":identityNumber,
    "providenceId":providenceId,
    "districtID":districtID,
    "neighborhoodID":neighborhoodID,
    "mobilePhone":mobilePhone,
    "email":email,
    "resultDate":resultDate,
    "name":name,
    "outarized":outarized,
    "userStatus":userStatus,
    "gender":gender,
    "birthDate":birthDate,
    "educationState":educationState,
    "jobID":jobID,
  };

}
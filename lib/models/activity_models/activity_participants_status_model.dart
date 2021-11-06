import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';

class ActivityParticipantsStatusModel extends BaseModel {
  @override
  int outarized;

  @override
  DateTime resultDate;

  int id;
  String name;
  String surname;
  int activityParticipantStatus;
  String excuse;
  String imageURL;

  ActivityParticipantsStatusModel({
    this.id,
    this.name,
    this.surname,
    this.activityParticipantStatus,
    this.excuse,
    this.imageURL,
});




  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, Object> map) => ActivityParticipantsStatusModel(
    id: map["id"],
    name: map["name"],
    surname: map["surname"],
    activityParticipantStatus: map["activityParticipantStatus"],
    excuse: map["excuse"],
    imageURL: map["imageURL"],
  );



  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, Object> toMap() =>{
    "id":id,
    "name":name,
    "surname":surname,
    "excuse":excuse,
    "activityParticipantStatus":activityParticipantStatus,
    "imageURL":imageURL,
  };

}
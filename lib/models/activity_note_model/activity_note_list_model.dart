import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';
import 'package:deva_test/models/component_models/note_add_model.dart';

class ActivityNoteModel extends BaseModel{

  int id;
  String name;
  String desc;
  int activityID;
  String activity;

  ActivityNoteModel({
    this.id,
    this.name,
    this.desc,
    this.activityID,
    this.activity
  });

  @override
  int outarized;

  @override
  DateTime resultDate;

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, dynamic> map) =>ActivityNoteModel(
    id: map["id"],
    desc: map["desc"],
    name: map["name"],
    activity: map["activity"],
    activityID: map["activityID"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap()=> {
    "id":id,
    "name":name,
    "desc":desc,
    "activity":activity,
    "activityID":activityID
  };

}
import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';

class NoteAddDialogModel extends BaseModel{

  int id;
  String noteName;
  String desc;
  int activityID;
  int taskID;

  NoteAddDialogModel({this.id,this.noteName,this.activityID, this.desc,this.taskID});

  @override
  int outarized;

  @override
  DateTime resultDate;

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, dynamic> map) =>NoteAddDialogModel(
    id: map["id"],
    activityID: map["activityID"],
    taskID: map["taskID"],
    desc:map["desc"],
    noteName:map["noteName"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() =>{
    "id":id,
    "desc":desc,
    "noteName":noteName,
    "taskID":taskID,
    "activityID":activityID
  };


}
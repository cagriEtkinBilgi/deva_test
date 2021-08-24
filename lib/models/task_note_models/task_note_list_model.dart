import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';

class TaskNoteListModel extends BaseModel {
  @override
  int outarized;

  @override
  DateTime resultDate;
  int id;
  String name;
  String desc;
  String taskName;
  int taskID;


  TaskNoteListModel({this.outarized,
    this.resultDate,
    this.id,
    this.taskID,
    this.name,
    this.desc,
    this.taskName});

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, dynamic> map) => TaskNoteListModel(
    desc: map["desc"],
    name: map["name"],
    id: map["id"],
    taskID: map["taskID"],
    taskName: map["taskName"],
  );



  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() =>{
    "desc":desc,
    "name":name,
    "id":id,
    "taskID":taskID,
    "taskName":taskName
  };
}
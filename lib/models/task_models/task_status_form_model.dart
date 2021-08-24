import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';

class TaskStatusFormModel extends BaseModel  {
  int id;
  int taskStatus;
  String startDate;
  String endDate;

  TaskStatusFormModel({this.id, this.taskStatus,
  this.startDate, this.endDate});

  @override
  int outarized;

  @override
  DateTime resultDate;

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, Object> map) =>TaskStatusFormModel(
    taskStatus:map["taskStatus"],
    id:map["id"],
    endDate:map["endDate"],
    startDate:map["startDate"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, Object> toMap() =>{
    "id":id,
    "endDate":endDate,
    "startDate":startDate,
    "taskStatus":taskStatus,
  };
  
  
  
}
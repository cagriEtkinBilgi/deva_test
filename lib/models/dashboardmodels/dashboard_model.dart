import 'dart:convert';
import 'package:deva_test/models/base_models/base_model.dart';

class DashboardModel extends BaseModel {
  int workGroupsCount;
  int tasksCount;
  int taskNotesCount;
  int activitiesCount;
  int usersCount;
  int publicActivitiesCount;



  DashboardModel({
    this.workGroupsCount,
    this.tasksCount,
    this.taskNotesCount,
    this.activitiesCount,
    this.publicActivitiesCount,
  });


  DashboardModel fromJson(str)=> fromMap(json.decode(str));

  @override
  fromMap(Map<String, dynamic> map) =>DashboardModel(
    taskNotesCount: map["taskNotesCount"],
    workGroupsCount: map["workGroupsCount"],
    tasksCount: map["tasksCount"],
    activitiesCount: map["activitiesCount"],
    publicActivitiesCount:map["publicActivitiesCount"],
  );


  String toJson()=>json.encode(toMap());

  @override
  Map<String, dynamic> toMap()=> {
    "taskNotesCount":taskNotesCount,
    "workGroupsCount":workGroupsCount,
    "tasksCount":tasksCount,
    "usersCount":usersCount,
    "publicActivitiesCount":publicActivitiesCount
  };

  @override
  int outarized;

  @override
  DateTime resultDate;
















}
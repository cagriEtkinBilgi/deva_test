import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';

class ActivityCompleteModel extends BaseModel{
  @override
  int outarized;
  int id;
  String summary;
  String returns;
  String locationName;
  String startDateStr;
  String startTime;
  String endDateStr;
  String endTime;


  @override
  DateTime resultDate;

  ActivityCompleteModel({
    this.id,
    this.summary,
    this.returns,
    this.startDateStr,
    this.startTime,
    this.endDateStr,
    this.endTime,
    this.locationName
  });

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, Object> map) =>ActivityCompleteModel(
    id: map["id"],
    returns:map["returns"],
    summary:map["summary"],
    endDateStr:map["endDateStr"],
    endTime:map["endTime"],
    startTime: map["startTime"],
    startDateStr:map["startDateStr"],
    locationName:map["locationName"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, Object> toMap() => {
    "id":id,
    "returns":returns,
    "summary":summary,
    "endDateStr":endDateStr,
    "endTime":endTime,
    "startDateStr":startDateStr,
    "startTime":startTime,
    "locationName":locationName
  };

}
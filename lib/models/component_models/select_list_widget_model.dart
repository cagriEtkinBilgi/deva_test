import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';

import 'check_list_model.dart';

class SelectListWidgetModel extends BaseModel  {
  int id;
  String title;
  String subTitle;
  bool selected;

  SelectListWidgetModel({
    this.title,
    this.id,
    this.subTitle,
    this.selected,
    this.outarized,
    this.resultDate,
  });
  @override
  String toString() {
    return "$id "+title;
  }

  @override
  int outarized;

  @override
  DateTime resultDate;

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, Object> map)=>SelectListWidgetModel(
    id:map["id"],
    subTitle:map["subTitle"],
    title:map["title"],
    selected:map["selected"],
    outarized:map["outarized"],
    resultDate: map["resultDate"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, Object> toMap() =>{
    "id":id,
    "title":title,
    "subTitle":subTitle,
    "selected":selected,
    "outarized":outarized,
    "resultDate":resultDate
  };

  CheckListModel toCheckListModel()=>CheckListModel(
    id: id,
    name: title,
    value: selected,
  );
}
import 'dart:convert';
import 'package:deva_test/models/base_models/base_model.dart';
import 'package:deva_test/models/component_models/select_list_widget_model.dart';

class CheckListModel extends BaseModel {

  int id;
  String name;
  bool value;

  CheckListModel({this.id, this.name, this.value});

  @override
  int outarized;

  @override
  DateTime resultDate;

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, dynamic> map) =>CheckListModel(
    id: map["id"],
    value:map["value"],
    name:map["name"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap()=> {
    "id":id,
    "value":value,
    "name":name
  };
  SelectListWidgetModel toSelectListWidgetModel()=> SelectListWidgetModel(
    resultDate: resultDate,
    title: name,
    selected: value,
    id: id,
  );
}
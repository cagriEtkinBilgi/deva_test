import 'dart:convert';
import 'package:deva_test/models/base_models/base_model.dart';

import 'check_list_model.dart';

class DropdownSearchModel extends BaseModel{

  int id;
  String value;

  DropdownSearchModel({this.id, this.value});

  @override
  int outarized;

  @override
  DateTime resultDate;

  @override
  fromJson(String str)=>fromMap(json.decode(str));

  @override
  fromMap(Map<String, dynamic> map) =>DropdownSearchModel(
    id: map["id"],
    value: map["value"],
  );

  @override
  String toJson() =>json.encode(toMap());

  @override
  Map<String, dynamic> toMap()=> {
    "id":id,
    "value":value
  };

  @override
  String toString()=>value;

  CheckListModel toCheckListModel()=>CheckListModel(
      id: id,
      value: false,
      name: value
  );
}

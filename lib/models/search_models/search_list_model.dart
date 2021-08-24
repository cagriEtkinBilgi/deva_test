import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';

class SearchListModel extends BaseModel {


  int id;
  String title;


  SearchListModel({this.id, this.title});

  @override
  int outarized;

  @override
  DateTime resultDate;

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, dynamic> map) =>SearchListModel(
    id: map["id"],
    title: map["title"]
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {
    "id":id,
    "title":title
  };

}
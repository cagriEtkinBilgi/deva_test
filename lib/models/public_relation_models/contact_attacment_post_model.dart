import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';
import 'package:deva_test/models/component_models/attachment_dialog_model.dart';

class ContactAttacmentPostModel extends BaseModel{
  @override
  int outarized;

  @override
  DateTime resultDate;

  int id;
  List<AttachmentDialogModel> Images;

  ContactAttacmentPostModel({
    this.id,
    this.Images,
    this.resultDate,
    this.outarized,
  });

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, Object> map) => ContactAttacmentPostModel(
    outarized: map["outarized"],
    resultDate: map["resultDate"],
    id: map["id"],
    Images: map["Images"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, Object> toMap() => {
    "outarized":outarized,
    "resultDate":resultDate,
    "Images":Images,
    "id":id,
  };

}
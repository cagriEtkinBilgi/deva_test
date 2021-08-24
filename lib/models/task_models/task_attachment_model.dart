import 'dart:convert';
import 'package:deva_test/models/component_models/photo_gallery_model.dart';
import 'package:deva_test/models/base_models/base_model.dart';

class TaskAttachmentModel extends BaseModel {
  @override
  int outarized;

  @override
  DateTime resultDate;
  int id;
  int taskID;
  String taskName;
  String name;
  String desc;
  String url;
  String fullURL;


  TaskAttachmentModel({this.outarized,
    this.resultDate,
    this.id,
    this.taskID,
    this.taskName,
    this.name,
    this.desc,
    this.fullURL,
    this.url});

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, dynamic> map) =>TaskAttachmentModel(
    taskName: map["taskName"],
    id: map["id"],
    taskID: map["taskID"],
    name: map["name"],
    desc: map["desc"],
    url: map["url"],
    fullURL: map["fullURL"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap()=> {
    "taskName":taskName,
    "id":id,
    "taskID":taskID,
    "name":name,
    "desc":desc,
    "url":url,
    "fullURL":fullURL
  };

  PhotoGalleryModel toPhotoGalleryModel()=>PhotoGalleryModel(
    id: id,
    imageName: name,
    imageUrl: fullURL,
  );




}
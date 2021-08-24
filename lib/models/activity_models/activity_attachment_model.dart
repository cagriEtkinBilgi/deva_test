import 'dart:convert';
import 'package:deva_test/models/base_models/base_model.dart';
import 'package:deva_test/models/component_models/photo_gallery_model.dart';

class ActivityAttachmentModel extends BaseModel{

  int id;
  int activityID;
  String activity;
  String name;
  String desc;
  String url;
  String fullURL;


  ActivityAttachmentModel({
    this.id,
    this.activityID,
    this.activity,
    this.name,
    this.desc,
    this.fullURL,
    this.url});

  @override
  int outarized;

  @override
  DateTime resultDate;

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, Object> map) =>ActivityAttachmentModel(
    id: map["id"],
    name: map["name"],
    desc: map["desc"],
    url: map["url"],
    fullURL: map["fullURL"],
    activity: map["activity"],
    activityID: map["activityID"],
  );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, Object> toMap() =>{
    "id":id,
    "name":name,
    "desc":desc,
    "activity":activity,
    "activityID":activityID,
    "fullURL":fullURL
  };

  PhotoGalleryModel toPhotoGalleryModel() =>PhotoGalleryModel(
    imageUrl: fullURL,
    imageName: name,
    id: id,
  );


}
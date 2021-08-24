import 'package:deva_test/models/component_models/dropdown_search_model.dart';
import 'package:flutter/cupertino.dart';

class AppTools{
  static String AppName="Deva";
  static getAppBarElevation(){
    if(TargetPlatform==TargetPlatform.android){
      return 0.0;
    }else if(TargetPlatform==TargetPlatform.android){
      return 5.0;
    }
  }
  static List<DropdownSearchModel> getRepetitionStatus(){
    var repetitionStatus=List<DropdownSearchModel>();
    repetitionStatus.add(DropdownSearchModel(id: 0,value: "Tekrarlanmıyor"));
    repetitionStatus.add(DropdownSearchModel(id: 1,value: "Günlük"));
    repetitionStatus.add(DropdownSearchModel(id: 2,value: "Haftalık"));
    repetitionStatus.add(DropdownSearchModel(id: 3,value: "Aylık"));
    return repetitionStatus;
  }

  static List<DropdownSearchModel> getTaskStatus(){
    var repetitionStatus=List<DropdownSearchModel>();
    repetitionStatus.add(DropdownSearchModel(id: 0,value: "Başlamadı"));
    repetitionStatus.add(DropdownSearchModel(id: 1,value: "Devam Ediyor"));
    repetitionStatus.add(DropdownSearchModel(id: 2,value: "Tamamlandı"));
    repetitionStatus.add(DropdownSearchModel(id: 3,value: "İptal Edildi"));
    repetitionStatus.add(DropdownSearchModel(id: 4,value: "Onaylandı"));
    return repetitionStatus;
  }

  static List<DropdownSearchModel> getPriority(){
    var repetitionStatus=List<DropdownSearchModel>();
    repetitionStatus.add(DropdownSearchModel(id: 0,value: "Düşük"));
    repetitionStatus.add(DropdownSearchModel(id: 1,value: "Orta"));
    repetitionStatus.add(DropdownSearchModel(id: 2,value: "Önemli"));
    repetitionStatus.add(DropdownSearchModel(id: 3,value: "Acil"));//Bu alan Apilar tamamalanınca silinecek
    return repetitionStatus;
  }
  static List<DropdownSearchModel> getGender(){
    var repetitionStatus=List<DropdownSearchModel>();
    repetitionStatus.add(DropdownSearchModel(id: 0,value: "Kadın"));
    repetitionStatus.add(DropdownSearchModel(id: 1,value: "Erkek"));
    repetitionStatus.add(DropdownSearchModel(id: 2,value: "Belirtilmemiş"));
    //Bu alan Apilar tamamalanınca silinecek
    return repetitionStatus;
  }
  //static String apiUri="https://www.devaportal.org";
//mazeret ekele sekili düzeltilecek
  static String apiUri="https://192.168.1.23:45461";
}
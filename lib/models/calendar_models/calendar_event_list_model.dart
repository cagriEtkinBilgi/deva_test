import 'dart:convert';

import 'package:deva_test/models/base_models/base_model.dart';
import 'package:deva_test/models/calendar_models/calendar_event_model.dart';
import 'package:deva_test/tools/date_parse.dart';

class CalendarEventListModel extends BaseModel {

  int id;
  DateTime date;
  String dateStr;
  List<CalendarEventModel> events;

  @override
  int outarized;

  @override
  DateTime resultDate;


  CalendarEventListModel({
    this.events,this.id,this.date,this.dateStr, this.outarized});

  @override
  fromJson(String str) => fromMap(json.decode(str));

  @override
  fromMap(Map<String, dynamic> map) {
   var model=CalendarEventListModel(
     id:map["id"],
     dateStr: map["dateStr"],
   );
   model.date= DateParseTools.instance.StrToDate(model.dateStr);
   if(map["dayEvents"]!=null){
     var events=List<CalendarEventModel>();
     for(var event in map["dayEvents"]){
        events.add(CalendarEventModel().fromMap(event));
     }
     model.events=events;
   }
   return model;
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap()=> {
    'id':id,
    'dateStr':DateParseTools.instance.DateToStr(date),
    'date':date,
    'dayEvents':(this.events!=null)?this.events.map((u)=>u.toMap()).toList():"",
  };

}
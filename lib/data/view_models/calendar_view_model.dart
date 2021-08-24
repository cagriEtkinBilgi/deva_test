import 'package:deva_test/data/repositorys/calendar_repository.dart';
import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/calendar_models/calendar_event_list_model.dart';
import 'package:deva_test/tools/date_parse.dart';
import 'package:deva_test/tools/locator.dart';
import '../error_model.dart';
import 'base_view_model.dart';

class CalendarViewModel extends BaseViewModel {

  var repo=locator<CalendarRepository>();

  Map<DateTime, List<dynamic>> events;
  List selectedEvents;
  var selectedDate=DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;


  Future<List<CalendarEventListModel>> getCalenderTasks(String startDate,String endDate) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      if(startDate==""&&endDate==""){
        var currentDates=getCurrentDates();
        startDate=currentDates["first"];
        endDate=currentDates["last"];
      }
      BaseListModel<CalendarEventListModel> retVal;
      retVal=await repo.getCalenderTasks(sesion.token,startDate,endDate);
      events= getEventMaps(retVal.datas);
      selectedEvents= events[selectedDate] ?? [];
      print(selectedDate);
      setState(ApiStateEnum.LoadedState);
      return null;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError.message=e.toString();
      }
      throw e;
    }
  }

  changeSelectedEvent(DateTime _selectedDay){
    var testDate=DateTime(_selectedDay.year,_selectedDay.month,_selectedDay.day);
    selectedEvents= events[testDate] ?? [];
    selectedDate=testDate;
    setState(ApiStateEnum.LoadedState);
  }

  Map<String,String> getCurrentDates(){
    try{
      var date=DateTime.now();
      var first=DateTime(date.year,date.month,1);
      var last=DateTime(date.year,date.month+1).add(Duration(days: -1));
      var strFirst=DateParseTools.instance.DateToStr(first);
      var strLast=DateParseTools.instance.DateToStr(last);
      var retVal={"first":strFirst,"last":strLast};
      return retVal;
    }catch(e){
      print(e.toString());
    }


  }


  getEventMaps(List<CalendarEventListModel> model){

    final mapEvents=Map<DateTime ,List<dynamic>>();

    for(var data in model){
      var mapList=List<dynamic>();
      for(var event in data.events){
        mapList.add(event.toMap());
      }
      mapEvents.putIfAbsent(data.date, () => mapList);
    }
    return mapEvents;
  }

}
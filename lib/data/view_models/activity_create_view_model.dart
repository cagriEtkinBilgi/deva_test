import 'package:deva_test/data/repositorys/activity_repository.dart';
import 'package:deva_test/data/view_models/base_view_model.dart';
import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/activity_models/activity_form_model.dart';
import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/component_models/select_list_widget_model.dart';
import 'package:deva_test/tools/locator.dart';

import '../error_model.dart';

var repo=locator<ActivityRepository>();

class ActivityCreateViewModel extends BaseViewModel{

  List<SelectListWidgetModel> workGroupSelectList;
  List<SelectListWidgetModel> categoriSelectList;
  List<SelectListWidgetModel> participantSelectList;

  Future<List<SelectListWidgetModel>> getActivityWorkGroup() async {
    try{
      if(workGroupSelectList==null){
        print(workGroupSelectList);
        var sesion=await SecurityViewModel().getCurrentSesion();
        BaseListModel<SelectListWidgetModel> retVal= await repo.getActivityWorkGroups(sesion.token);
        workGroupSelectList=retVal.datas;
        canEdit=(retVal.outarized==2);
      }
      setState(ApiStateEnum.LoadedState);
      return workGroupSelectList;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }

  }

  Future<List<SelectListWidgetModel>> getActivityActivityCategori() async {
    try{
      if(categoriSelectList==null){
        var sesion=await SecurityViewModel().getCurrentSesion();
        BaseListModel<SelectListWidgetModel> retVal= await repo.getActivityCategory(sesion.token);
        categoriSelectList=retVal.datas;
        canEdit=(retVal.outarized==2);
      }
      setState(ApiStateEnum.LoadedState);
      return categoriSelectList;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }

  }
  Future<List<SelectListWidgetModel>> getActivityActivityParticipant(int ID) async {
    try{
      if(participantSelectList==null){
        var sesion=await SecurityViewModel().getCurrentSesion();
        BaseListModel<SelectListWidgetModel> retVal= await repo.getActivityParticipant(sesion.token,ID);
        participantSelectList=retVal.datas;
        canEdit=(retVal.outarized==2);
      }
      setState(ApiStateEnum.LoadedState);
      return participantSelectList;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }

  }
  Future<bool> createActivityPlan(ActivityFormModel model)async{
    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityFormModel> retVal;
      retVal= await repo.createActivityPlan(sesion.token,model);
      setState(ApiStateEnum.LoadedState);
      return true;
    }catch(e){
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }
  }

  Future<bool> createActivity(ActivityFormModel model) async {
    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityFormModel> retVal;
      retVal= await repo.createActivity(sesion.token,model);
      setState(ApiStateEnum.LoadedState);
      return true;
    }catch(e){
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }

  }
  void setLoaded(){
    setState(ApiStateEnum.LoadedState);
  }

}
import 'package:deva_test/data/error_model.dart';
import 'package:deva_test/data/repositorys/activity_repository.dart';
import 'package:deva_test/data/view_models/base_view_model.dart';
import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/activity_models/activity_attachment_model.dart';
import 'package:deva_test/models/activity_models/activity_coplete_model.dart';
import 'package:deva_test/models/activity_models/activity_detail_model.dart';
import 'package:deva_test/models/activity_models/activity_form_model.dart';
import 'package:deva_test/models/activity_models/activity_list_model.dart';
import 'package:deva_test/models/activity_models/activity_participants_model.dart';
import 'package:deva_test/models/activity_note_model/activity_note_list_model.dart';
import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/component_models/attachment_dialog_model.dart';
import 'package:deva_test/models/component_models/check_list_model.dart';
import 'package:deva_test/models/component_models/dropdown_search_model.dart';
import 'package:deva_test/models/component_models/note_add_model.dart';
import 'package:deva_test/tools/locator.dart';




class ActivityViewModel extends BaseViewModel{

  List<ActivityListModel> activitys;
  List<ActivityNoteModel> activityNotes;
  List<ActivityAttachmentModel> activityFiles;
  List<ActivityAttachmentModel> activityImages;
  ActivityDetailModel activity;
  ActivityFormModel formModel;
  ActivityCompleteModel completeFormModel;


  var repo=locator<ActivityRepository>();

  Future<List<ActivityListModel>> getActivitys(int typeID) async {
    PageID=1;
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityListModel> retVal;
      if(typeID==1)
        retVal=await repo.getPublicActivitys(sesion.token, 0);
      else
        retVal=await repo.getActivitys(sesion.token, 0);

      activitys=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return activitys;
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

  Future<List<ActivityNoteModel>> getActivityNotes(int ID) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityNoteModel> retVal= await repo.getActivityNotes(sesion.token, ID);
      activityNotes=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return activityNotes;
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

  Future<List<ActivityAttachmentModel>> getActivityFiles(int ID) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityAttachmentModel> retVal= await repo.getActivityFiles(sesion.token, ID);
      activityFiles=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return activityFiles;
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

  Future<List<ActivityAttachmentModel>> getActivityImage(int ID) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityAttachmentModel> retVal= await repo.getActivityImage(sesion.token, ID);
      activityImages=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return activityImages;
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

  Future<List<ActivityListModel>> getActivityNextPage(int typeID) async{
    isPageLoding=true;
    notifyListeners();
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityListModel> retVal;
      if(typeID==1)
        retVal=await repo.getPublicActivitys(sesion.token, PageID);
      else
        retVal=await repo.getActivitys(sesion.token, PageID);

      if(retVal.datas.length!=0){
        activitys.addAll(retVal.datas);
        PageID++;
      }
      setState(ApiStateEnum.LoadedState);
      isPageLoding=false;
      return retVal.datas;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      print(apiState.toString());
      throw e;
    }

  }

  Future<ActivityDetailModel> getActivity(int id) async{
    try{

      var sesion=await SecurityViewModel().getCurrentSesion();
      activity= await repo.getActivity(sesion.token, id);
      setState(ApiStateEnum.LoadedState);
      return activity;
    }catch (e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }
  }

  Future<ActivityFormModel> getActivityForm(int id) async{
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<DropdownSearchModel> categorys= await repo.getActivityCategorys(sesion.token);
      if(id==null)
        formModel=ActivityFormModel();
      else{
        var activity= await repo.getActivity(sesion.token, id);
        formModel=activity.toFormModel();
        print(activity.toJson());
      }
      formModel.categorySelects=categorys.datas;
      setState(ApiStateEnum.LoadedState);
      return formModel;
    }catch(e){
      throw e;
    }

  }

  Future<bool> createActivity(ActivityFormModel model) async {

    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityFormModel> retVal;
      if(model.id==null)
        retVal= await repo.createActivity(sesion.token,model);
      else
        retVal= await repo.updateActivity(sesion.token,model);
      setState(ApiStateEnum.LoadedState);
      return true;
    }catch(e){
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }

  }

  Future <List<CheckListModel>> getParticipantsUser(int id) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityParticipantsModel> retVal= await repo.getParticipantsUser(sesion.token, id);
      var models =retVal.datas.map((e) => e.toCheckListModel()).toList();
      return models;
    }catch(e){
      return e;
    }

  }

  Future <List<CheckListModel>> getInvadedUser(int id) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<DropdownSearchModel> retVal= await repo.getInvadedUser(sesion.token, id);
      var models =retVal.datas.map((e) => e.toCheckListModel()).toList();
      return models;
    }catch(e){
      return e;
    }

  }

  Future <bool> updateParticipantsUser(List<CheckListModel> chkModels,int id) async {
    try{
      var listUser=List<ActivityParticipantsModel>();
      for(var item in chkModels){
        listUser.add(ActivityParticipantsModel(
          id: item.id,
          userNameSurname: item.name,
          participationStatus: item.value,
        ));
      }
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityParticipantsModel> retVal= await repo.updateParticipantsUser(sesion.token,listUser);
      return true;
    }catch(e){
      throw e;
    }

  }

  Future <bool> addUserToActivity(List<CheckListModel> chkModels,int id) async {
    try{
      var listUser=List<ActivityParticipantsModel>();
      for(var item in chkModels){
        if(item.value){
          listUser.add(ActivityParticipantsModel(
            id: item.id,
            activityID: id,
            userID: item.id,
            userNameSurname: item.name,
            participationStatus: item.value,
          ));
        }
      }
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityParticipantsModel> retVal= await repo.addUserToActivity(sesion.token,listUser);
      return true;
    }catch(e){
      throw e;
    }

  }

  Future<bool> addActivityNote(NoteAddDialogModel model) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<NoteAddDialogModel> retVal= await repo.addActivityNote(sesion.token,model);
      await getActivityNotes(model.activityID);
      return true;
    }catch(e){
      throw e;
    }

  }

  Future<bool> addActivityFile(AttachmentDialogModel model,int type) async {
    try{
      isPageLoding=true;
      notifyListeners();
      //Apiye Bağlanacak ve test edilecek
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<AttachmentDialogModel> retVal= await repo.addActivityFile(sesion.token,model);
      isPageLoding=false;
      if(type==1){
        await getActivityImage(model.id);
      }else{
        await getActivityFiles(model.id);
      }
      return true;
    }catch(e){
      print(e.toString());
      throw e.toString();
    }

  }

  Future<bool> deleteActivityNote(ActivityNoteModel model) async {

    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityFormModel>
        retVal= await repo.deleteActivityNote(sesion.token,model.id);
      await getActivityNotes(model.activityID);
      return true;
    }catch(e){
      return false;
    }

  }

  Future<bool> deleteActivityAttachment(ActivityAttachmentModel model,int type) async {

    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityFormModel>
      retVal= await repo.deleteActivityAttachment(sesion.token,model.id);
      if(type==1){
        await getActivityImage(model.activityID);
      }else{
        await getActivityFiles(model.activityID);
      }

      return true;
    }catch(e){
      return false;
    }

  }

  Future<ActivityCompleteModel> getActivityComplateForm(int id) async{
    try{
      //Get FormModel Apisi İncelenecek
      completeFormModel=ActivityCompleteModel();
      setState(ApiStateEnum.LoadedState);
      return completeFormModel;
    }catch(e){
      throw e;
    }

  }

  Future<bool> completeActivity(ActivityCompleteModel model) async {
    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityFormModel> retVal;
        retVal= await repo.completeActivity(sesion.token,model);
        setState(ApiStateEnum.LoadedState);
      return true;
    }catch(e){
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }

  }

  Future<bool> addActivityExcuse(NoteAddDialogModel model) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<NoteAddDialogModel> retVal= await repo.addActivityExcuse(sesion.token,model);
      //kayıt işlemi test edilecek not ekelem dialoğuna isim ve yazı düzeltmeleri yapılacak!
      return true;
    }catch(e){
      throw e;
    }

  }

}
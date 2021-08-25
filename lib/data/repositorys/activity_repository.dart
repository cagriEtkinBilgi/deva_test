import 'package:deva_test/data/repositorys/base_api.dart';
import 'package:deva_test/models/activity_models/activity_attachment_model.dart';
import 'package:deva_test/models/activity_models/activity_coplete_model.dart';
import 'package:deva_test/models/activity_models/activity_detail_model.dart';
import 'package:deva_test/models/activity_models/activity_form_model.dart';
import 'package:deva_test/models/activity_models/activity_list_model.dart';
import 'package:deva_test/models/activity_models/activity_participants_model.dart';
import 'package:deva_test/models/activity_note_model/activity_note_list_model.dart';
import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/component_models/attachment_dialog_model.dart';
import 'package:deva_test/models/component_models/dropdown_search_model.dart';
import 'package:deva_test/models/component_models/note_add_model.dart';
import 'package:deva_test/models/component_models/select_list_widget_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';



class ActivityRepository {

  Future<BaseListModel> getActivitys(String token, int pageID) async {
    try {
      BaseListModel<ActivityListModel> response =
      await BaseApi.instance.dioGet<ActivityListModel>(
          "/Activity/GetUserActivities/$pageID", ActivityListModel(),
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> getPublicActivitys(String token, int pageID) async {
    try {
      BaseListModel<ActivityListModel> response =
      await BaseApi.instance.dioGet<ActivityListModel>(
          "/Activity/GetPublicActivies/$pageID", ActivityListModel(),
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> getActivityNotes(String token, int ID) async {
    try {
      BaseListModel<ActivityNoteModel> response =
      await BaseApi.instance.dioGet<ActivityNoteModel>(
          "/Activity/GetActivityNotes/$ID", ActivityNoteModel(),
          token: token);
      print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> getActivityWorkGroups(String token) async {
    try {
      BaseListModel<SelectListWidgetModel> response =
      await BaseApi.instance.dioGet<SelectListWidgetModel>(
          "/WorkGroup/GetAllAuthWorkGroups", SelectListWidgetModel(),
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<BaseListModel> getActivityCategory(String token) async {
    try {
      BaseListModel<SelectListWidgetModel> response =
      await BaseApi.instance.dioGet<SelectListWidgetModel>(
          "/Activity/GetCategoryByCreateForm", SelectListWidgetModel(),
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<BaseListModel> getActivityParticipant(String token,int ID) async {
    try {
      BaseListModel<SelectListWidgetModel> response =
      await BaseApi.instance.dioGet<SelectListWidgetModel>(
          "/Activity/GetParticipantByCreateForm/${ID}", SelectListWidgetModel(),
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> getActivityFiles(String token, int ID) async {
    try {
      BaseListModel<ActivityAttachmentModel> response =
      await BaseApi.instance.dioGet<ActivityAttachmentModel>(
          "/Activity/GetActivityFiles/$ID", ActivityAttachmentModel(),
          token: token);
      print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> getActivityImage(String token, int ID) async {
    try {
      BaseListModel<ActivityAttachmentModel> response =
      await BaseApi.instance.dioGet<ActivityAttachmentModel>(
          "/Activity/GetActivityImages/$ID", ActivityAttachmentModel(),
          token: token);
      print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<ActivityDetailModel> getActivity(String token, int id) async {
    if (id == null)
      id = 0;
    try {
      ActivityDetailModel response =
      await BaseApi.instance.dioGet<ActivityDetailModel>(
          "/Activity/GetActivityDetail/$id", ActivityDetailModel(),
          token: token);


      return response;
    } catch (e) {

      throw e;
    }
  }

  Future<BaseListModel> getParticipantsUser(String token, int id) async{
    if (id == null)
      id = 0;
    try {
      BaseListModel<ActivityParticipantsModel> response =
      await BaseApi.instance.dioGet<ActivityParticipantsModel>(
          "/Activity/GetActivityParticipants/$id", ActivityParticipantsModel(),
          token: token);
      print(response.datas);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  Future<BaseListModel> getInvadedUser(String token, int id) async{
    if (id == null)
      id = 0;
    try {
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance.dioGet<DropdownSearchModel>(
          "/User/GetUsersCanAddActivity/$id", DropdownSearchModel(),
          token: token);
      print(response.datas);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseListModel> updateParticipantsUser(String token, List<ActivityParticipantsModel> models) async{
    try {
      var listMap=List<Map>();
      for(var item in models ){
        listMap.add(item.toMap());
      }
      var formData=FormData.fromMap({"models":listMap});
      BaseListModel<ActivityParticipantsModel> response =
      await BaseApi.instance.dioPost<ActivityParticipantsModel>(
          "/Activity/UpdateActivityParticipants", ActivityParticipantsModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseListModel> addUserToActivity(String token, List<ActivityParticipantsModel> models) async{
    try {
      var listMap=List<Map>();
      for(var item in models ){
        listMap.add(item.toMap());
      }
      var formData=FormData.fromMap({"models":listMap});
      BaseListModel<ActivityParticipantsModel> response =
      await BaseApi.instance.dioPost<ActivityParticipantsModel>(
          "/Activity/AddUsersToActivity", ActivityParticipantsModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseListModel> addActivityNote(String token,NoteAddDialogModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      BaseListModel<ActivityParticipantsModel> response =
          await BaseApi.instance.dioPost<NoteAddDialogModel>(
          "/Activity/AddAndUpdateNote", NoteAddDialogModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> addActivityFile(String token,AttachmentDialogModel model) async {
    try {
      //deavm edilecek!!
      print(model.toMap());
      var bodyMap=model.toMap();
      bodyMap["file"]=await MultipartFile.fromFile(model.filePath,filename: model.name);
      var formData=FormData.fromMap(bodyMap);
      BaseListModel<AttachmentDialogModel> response =
          await BaseApi.instance.dioPost<AttachmentDialogModel>(
          "/Activity/UploadFile", AttachmentDialogModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseListModel> getActivityCategorys(String token) async {
    try {
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance.dioGet<DropdownSearchModel>(
          "/Activity/GetActivityTypes", DropdownSearchModel(),
          token: token);
      //print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<BaseListModel> getActivityCategorysByStepper(String token) async {
    try {
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance.dioGet<DropdownSearchModel>(
          "/Activity/GetActivityTypes", DropdownSearchModel(),
          token: token);
      //print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> createActivity(String token,ActivityFormModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      BaseListModel<ActivityFormModel> response =
      await BaseApi.instance.dioPost<ActivityFormModel>(
          "/Activity/CreateComplated", ActivityFormModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }


  Future<BaseListModel> updateActivity(String token,ActivityFormModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      BaseListModel<ActivityFormModel> response =
      await BaseApi.instance.dioPost<ActivityFormModel>(
          "/Activity/Update", ActivityFormModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> completeActivity(String token,ActivityCompleteModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      BaseListModel<ActivityCompleteModel> response =
      await BaseApi.instance.dioPost<ActivityCompleteModel>(
          "/Activity/SaveReturns", ActivityCompleteModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> deleteActivityNote(String token,int id) async {
    try {
      var formData=FormData.fromMap({"ID":id});
      BaseListModel<ActivityFormModel> response =
      await BaseApi.instance.dioPost<ActivityFormModel>(
          "/Activity/DeleteNote", ActivityFormModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> deleteActivityAttachment(String token,int id) async {
    try {
      var formData=FormData.fromMap({"ID":id});
      BaseListModel<ActivityFormModel> response =
      await BaseApi.instance.dioPost<ActivityFormModel>(
          "/Activity/DeleteFile", ActivityFormModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> addActivityExcuse(String token,NoteAddDialogModel model) async {
    try {
      //deavm edilecek!!

      var formData=FormData.fromMap(model.toMap());
      BaseListModel<ActivityParticipantsModel> response =
      await BaseApi.instance.dioPost<NoteAddDialogModel>(
          "/Activity/ExcuseSave", NoteAddDialogModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

}
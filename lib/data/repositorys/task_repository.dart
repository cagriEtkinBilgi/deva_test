import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/component_models/attachment_dialog_model.dart';
import 'package:deva_test/models/component_models/dropdown_search_model.dart';
import 'package:deva_test/models/component_models/note_add_model.dart';
import 'package:deva_test/models/task_models/task_attachment_model.dart';
import 'package:deva_test/models/task_models/task_detail_model.dart';
import 'package:deva_test/models/task_models/task_list_model.dart';
import 'package:deva_test/models/task_note_models/task_note_list_model.dart';
import 'package:deva_test/models/task_models/task_status_form_model.dart';
import 'package:dio/dio.dart';
import 'base_api.dart';

class TaskRepository{

  Future<BaseListModel> getTasks(String token,int pageID,int periot) async {
    try{
      //Apisi Gelince link Düzeletilecek!!
      BaseListModel<TaskListModel> response=
      await BaseApi.instance.dioGet<TaskListModel>("/Task/GetUserTasks/$pageID/$periot",TaskListModel(),token: token);
      return response;
    }catch(e){
      throw e;
    }
  }
  Future<BaseListModel> getTaskNotes(String token,int id) async {
    try{
      //Apisi Gelince link Düzeletilecek!!
      BaseListModel<TaskNoteListModel> response=
      await BaseApi.instance.dioGet<TaskNoteListModel>("/Task/GetTaskNotes/$id",TaskNoteListModel(),token: token);
      return response;
    }catch(e){
      throw e;
    }
  }
  Future<BaseListModel> getTaskFiles(String token,int id) async {
    try{
      //Apisi Gelince link Düzeletilecek!!
      BaseListModel<TaskAttachmentModel> response=
      await BaseApi.instance.dioGet<TaskAttachmentModel>("/Task/GetTaskFiles/$id",TaskAttachmentModel(),token: token);
      return response;
    }catch(e){
      throw e;
    }
  }
  Future<BaseListModel> getTaskImage(String token,int id) async {
    try{
      //Apisi Gelince link Düzeletilecek!!
      BaseListModel<TaskAttachmentModel> response=
      await BaseApi.instance.dioGet<TaskAttachmentModel>("/Task/GetTaskImages/$id",TaskAttachmentModel(),token: token);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<TaskDetailModel> getTask(String token,int id) async {
    try{
      //api test edilecek!!
      TaskDetailModel response=
      await BaseApi.instance.dioGet<TaskDetailModel>("/Task/Detail/$id",TaskDetailModel(),token: token);
      return response;
    }catch(e){
      print(e.toString());
      throw e;
    }
  }

  Future<BaseListModel> addTaskNote(String token,NoteAddDialogModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      BaseListModel<NoteAddDialogModel> response =
      await BaseApi.instance.dioPost<NoteAddDialogModel>(
          "/Task/AddAndUpdateNote", NoteAddDialogModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> setTaskStatus(String token,TaskStatusFormModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      BaseListModel<TaskStatusFormModel> response =
      await BaseApi.instance.dioPost<TaskStatusFormModel>(
          "/Task/SaveTaskUpdate", TaskStatusFormModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> addTaskFile(String token,AttachmentDialogModel model) async {
    try {
      //deavm edilecek!!
      print(model.toMap());
      var bodyMap=model.toMap();
      bodyMap["file"]=await MultipartFile.fromFile(model.filePath,filename: model.name);
      var formData=FormData.fromMap(bodyMap);
      BaseListModel<AttachmentDialogModel> response =
      await BaseApi.instance.dioPost<AttachmentDialogModel>(
          "/Task/UploadFile", AttachmentDialogModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseListModel> createTask(String token,TaskDetailModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      BaseListModel<TaskDetailModel> response =
      await BaseApi.instance.dioPost<TaskDetailModel>(
          "/Task/Create", TaskDetailModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<BaseListModel> updateTask(String token,TaskDetailModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      BaseListModel<TaskDetailModel> response =
      await BaseApi.instance.dioPost<TaskDetailModel>(
          "/Task/Update", TaskDetailModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> deleteTaskNote(String token,int id) async {
    try {
      var formData=FormData.fromMap({"ID":id});
      BaseListModel<TaskDetailModel> response =
      await BaseApi.instance.dioPost<TaskDetailModel>(
          "/Task/NoteDelete", TaskDetailModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> deleteTaskAttachment(String token,int id) async {
    try {
      var formData=FormData.fromMap({"ID":id});
      BaseListModel<TaskDetailModel> response =
      await BaseApi.instance.dioPost<TaskDetailModel>(
          "/Task/DeleteFile", TaskDetailModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<TaskDetailModel> deleteTask(String token,int id) async {
    try{
      //api test edilecek!!
      print(id);
      TaskDetailModel response=
      await BaseApi.instance.dioGet<TaskDetailModel>("/Task/Delete/$id",TaskDetailModel(),token: token);
      return response;
    }catch(e){
      print(e.toString());
      throw e;
    }
  }

  Future<BaseListModel> getTaskCategorys(String token) async {
    try {
      BaseListModel<DropdownSearchModel> response =
          await BaseApi.instance.dioGet<DropdownSearchModel>(
          "/Task/GetTaskCategories", DropdownSearchModel(),
          token: token);
      //print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> getTaskUsers(String token) async {
    try {
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance.dioGet<DropdownSearchModel>(
          "/User/GetAuthUsers", DropdownSearchModel(),
          token: token);
      //print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }

  }
}
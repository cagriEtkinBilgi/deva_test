import 'package:deva_test/models/activity_note_model/activity_note_list_model.dart';
import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/task_note_models/task_note_list_model.dart';
import 'base_api.dart';

class NoteRepository{

  Future<BaseListModel> getTaskNotes(String token,int pageID) async {
    //Api gelince url düzelecek
    try{
      BaseListModel<TaskNoteListModel> response=
      await BaseApi.instance.dioGet<TaskNoteListModel>("/Activity/GetActivitiesList/$pageID",TaskNoteListModel(),token: token);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<BaseListModel> getActivityNotes(String token,int pageID) async {
    //Api gelince url düzelecek
    try{
      BaseListModel<TaskNoteListModel> response=
      await BaseApi.instance.dioGet<ActivityNoteModel>("/Activity/GetActivitiesList/$pageID",ActivityNoteModel(),token: token);
      return response;
    }catch(e){
      throw e;
    }
  }


}
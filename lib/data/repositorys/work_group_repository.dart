import 'package:deva_test/models/activity_models/activity_list_model.dart';
import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/security/user_model.dart';
import 'package:deva_test/models/workgroups_models/workgroup_detail_model.dart';
import 'package:deva_test/models/workgroups_models/workgroups_model.dart';
import 'base_api.dart';

class WorkGroupRepository{

  Future<BaseListModel> getWorkGroups(String token,int pageID) async {
    var params ={"pageID":pageID};
    try{
      BaseListModel<WorkGroupModel> response=
      await BaseApi.instance.dioGet<WorkGroupModel>("/WorkGroup/GetWorkGroupsList/$pageID",WorkGroupModel(),token: token,params: params);

      return response;
    }catch(e){
      throw e;
    }
  }
  Future<WorkGroupDetailModel> getWorkGroup(String token,int id) async {

    try{
      WorkGroupDetailModel response=
      await BaseApi.instance.dioGet<WorkGroupDetailModel>("/WorkGroup/GetWorkGroupDetail/$id",WorkGroupDetailModel(),token: token,);
      return response;
    }catch(e){
      throw e;
    }
  }
  Future<BaseListModel> getWorkGroupActivitys(String token,int ID) async {
    var params ={"ID":ID};
    try{
      //Api Gelince Değişecek!
      BaseListModel<ActivityListModel> response=
      await BaseApi.instance.dioGet<ActivityListModel>("/Activity/GetWorkGroupNotComplatedActivities/$ID",ActivityListModel(),token: token,params: params);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<BaseListModel> getWorkGroupMember(String token,int ID) async {
    var params ={"ID":ID};
    try{
      //Api Gelince Değişecek!
      BaseListModel<UserModel> response=
      await BaseApi.instance.dioGet<UserModel>("/WorkGroup/GetWorkGroupMembers/$ID",UserModel(),token: token,params: params);
      return response;
    }catch(e){
      throw e;
    }
  }
}
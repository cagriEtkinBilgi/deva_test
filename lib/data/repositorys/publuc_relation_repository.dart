import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/component_models/dropdown_search_model.dart';
import 'package:deva_test/models/public_relation_models/public_relation_user_check_model.dart';
import 'package:deva_test/models/public_relation_models/public_relation_user_create_model.dart';
import 'package:dio/dio.dart';
import 'base_api.dart';

class PublicRelationRepository{

  Future<PublicRelationUserCheckModel> getUserByPhoneNumber(String token, String phoneNumber) async {
    try {
      //UrlApi Yazılınca Değişecek
      PublicRelationUserCheckModel response =
      await BaseApi.instance.dioGet<PublicRelationUserCheckModel>(
          "/PublicRelations/GetUserByPhoneNumber/$phoneNumber", PublicRelationUserCheckModel(),
          token: token);
      print(response.toJson());
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<BaseListModel> getUnits(String token) async {
    try {
      //birimleri getiren api yazılacak
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance.dioGet<DropdownSearchModel>(
          "/PublicRelations/GetUnits", DropdownSearchModel(),
          token: token);
      //print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }

  }

  Future<BaseListModel> getEventTypes(String token) async {
    try {
      //olay torlerini getiren api yazılacak
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance.dioGet<DropdownSearchModel>(
          "/PublicRelations/GetEventType", DropdownSearchModel(),
          token: token);
      //print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }

  }

  Future<BaseListModel> getProvidence(String token) async {
    try {
      //illeri getiren api yazılacak
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance.dioGet<DropdownSearchModel>(
          "/PublicRelations/GetProvincial", DropdownSearchModel(),
          token: token);
      //print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }

  }
  Future<BaseListModel> getDistrict(String token,int id) async {
    try {
      //ilçeleri getiren api yazılacak
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance.dioGet<DropdownSearchModel>(
          "/PublicRelations/GetDistrict/${id}", DropdownSearchModel(),
          token: token);
      //print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }

  }
  Future<BaseListModel> getNeighborhood(String token,int id) async {
    try {
      //mahalleleri getiren api yazılacak
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance.dioGet<DropdownSearchModel>(
          "/PublicRelations/GetNeighborhood/${id}", DropdownSearchModel(),
          token: token);
      //print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<BaseListModel> getUsers(String token) async {
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

  Future<BaseListModel> addPublicRelation(String token,PublicRelationUserCreateModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      BaseListModel<PublicRelationUserCreateModel> response =
      await BaseApi.instance.dioPost<PublicRelationUserCreateModel>(
          "/PublicRelations/SaveRelation", PublicRelationUserCreateModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

}
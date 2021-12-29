import 'package:deva_test/data/repositorys/publuc_relation_repository.dart';
import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/component_models/dropdown_search_model.dart';
import 'package:deva_test/models/public_relation_models/contact_attacment_post_model.dart';
import 'package:deva_test/models/public_relation_models/contact_create_result_model.dart';
import 'package:deva_test/models/public_relation_models/contact_phone_confirme_model.dart';
import 'package:deva_test/models/public_relation_models/new_contact_form_model.dart';
import 'package:deva_test/tools/locator.dart';
import '../error_model.dart';
import 'base_view_model.dart';

class ContactViewModel extends BaseViewModel{

  var repo=locator<PublicRelationRepository>();

  List<DropdownSearchModel> distinc;
  List<DropdownSearchModel> jops;

  Future<List<DropdownSearchModel>> getContactDistrict() async {
    try {
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<DropdownSearchModel> districtes= await repo.getDistrict(sesion.token,-1);//-1 e çekilecek
      distinc=districtes.datas;
      BaseListModel<DropdownSearchModel> jopesses= await repo.getJops(sesion.token);//-1 e çekilecek
      jops=jopesses.datas;
      setState(ApiStateEnum.LoadedState);
      return districtes.datas;
    } catch (e) {
      setState(ApiStateEnum.ErorState);
      throw e;
    }

  }
  Future<List<DropdownSearchModel>> getNeighborhood(int id) async {
    try {
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<DropdownSearchModel> neighborhoodes= await repo.getNeighborhood(sesion.token,id);
      return neighborhoodes.datas;
    } catch (e) {
      throw e;
    }

  }
  
  loadForm(){
    setState(ApiStateEnum.LoadedState);
  }

  Future<ContactCreateResultModel> addContact(NewContactFormModel model) async {
    try {
      //deavm edilecek!!
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      var retVal=await repo.addContact(sesion.token, model);

      setState(ApiStateEnum.LoadedState);
      print(retVal.toJson());
      return retVal;
    } catch (e) {
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }
  }

  Future<bool> confirmeMobilePhone(ContactPhoneConfirmeModel model) async {
    try {
      //deavm edilecek!!
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      var retVal=await repo.confirmeMobilePhone(sesion.token, model);
      setState(ApiStateEnum.LoadedState);
      return true;
    } catch (e) {
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }
  }

  Future<bool> addImagesContact(ContactAttacmentPostModel model) async {
    try {
      if(model.Images==null){
        return true;
      }
      //deavm edilecek!!
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      var retVal=await repo.addImagesContact(sesion.token, model);
      setState(ApiStateEnum.LoadedState);
      return true;
    } catch (e) {
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }
  }

  Future<ContactPhoneConfirmeModel> resendSmsToken(int id) async {
    try {
      var sesion=await SecurityViewModel().getCurrentSesion();
      print("resent work");
      var model=ContactPhoneConfirmeModel(id: id);
      var retVal=await repo.resendSmsToken(sesion.token, model);
      return retVal;
    } catch (e) {
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }
  }


}
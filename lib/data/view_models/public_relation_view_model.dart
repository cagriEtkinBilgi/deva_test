import 'package:deva_test/data/repositorys/publuc_relation_repository.dart';
import 'package:deva_test/data/view_models/base_view_model.dart';
import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/component_models/dropdown_search_model.dart';
import 'package:deva_test/models/public_relation_models/public_relation_user_check_model.dart';
import 'package:deva_test/models/public_relation_models/public_relation_user_create_model.dart';
import 'package:deva_test/tools/locator.dart';
import '../error_model.dart';

class PublicRelationViewModel extends BaseViewModel{

  PublicRelationUserCheckModel checkedModel;
  PublicRelationUserCreateModel createModel;
  String phoneNumber="";
  bool showUserCard=false;
  bool showResult=false;

  var repo=locator<PublicRelationRepository>();

  Future<PublicRelationUserCheckModel> getUserByPhoneNumber() async{
    try{

      showUserCard=false;
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<DropdownSearchModel> units= await repo.getUnits(sesion.token);
      createModel.unitSelectList=units.datas;
      BaseListModel<DropdownSearchModel> eventTypes= await repo.getEventTypes(sesion.token);
      createModel.eventSelectList=eventTypes.datas;
      BaseListModel<DropdownSearchModel> users= await repo.getUsers(sesion.token);
      createModel.userSelectList=users.datas;
      checkedModel= await repo.getUserByPhoneNumber(sesion.token, phoneNumber);
      checkedModel.phoneNumber=phoneNumber;
      createModel.phoneNumber=phoneNumber;
      showResult=true;
      createModel.referenceUserId=sesion.id;
      if(checkedModel.showCard==1){
        showUserCard=true;
        createModel.id=checkedModel.userID;
      }else{
        BaseListModel<DropdownSearchModel> providences= await repo.getProvidence(sesion.token);
        createModel.provinceSelectList=providences.datas;
      }
      setState(ApiStateEnum.LoadedState);
      return checkedModel;
    }catch (e){
      showResult=false;
      if(e is ErrorModel){
        onError=e;
      }else{
        onError.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);

    }
  }

  Future<List<DropdownSearchModel>> getDistrict(int id) async {
    try {
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<DropdownSearchModel> districtes= await repo.getDistrict(sesion.token,id);
      return districtes.datas;
    } catch (e) {
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

  Future<bool> addPublicRelation() async {
    try {
      //deavm edilecek!!
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      var retVal=await repo.addPublicRelation(sesion.token, createModel);
      setState(ApiStateEnum.LoadedState);
      return true;
    } catch (e) {
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }
  }

  pageReady(){
    setState(ApiStateEnum.LoadedState);
    createModel=PublicRelationUserCreateModel();
  }

}
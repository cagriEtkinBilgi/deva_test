import 'package:deva_test/data/repositorys/profile_repository.dart';
import 'package:deva_test/data/view_models/base_view_model.dart';
import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/user_models/user_profile_model.dart';
import 'package:deva_test/tools/locator.dart';
import '../error_model.dart';

class ProfileViewModel extends BaseViewModel{

  UserProfileModel profile;

  var repo=locator<ProfileRepository>();

  Future<UserProfileModel> getUserProfile(int id) async{
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      if(id==0)
        id=sesion.id;
      profile= await repo.getUserProfile(sesion.token,id);
      setState(ApiStateEnum.LoadedState);
      return profile;
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
  Future<UserProfileModel> pageReady(int id) async{
    if(profile!=null){
      setState(ApiStateEnum.LoadedState);
    }else{
      await getUserProfile(id);
      setState(ApiStateEnum.LoadedState);
    }
  }
  Future<bool> updateProfile() async {
    try {
      //deavm edilecek!!
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      var retVal=await repo.updateProfile(sesion.token, profile);
      setState(ApiStateEnum.LoadedState);
      return true;
    } catch (e) {
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }
  }
}
import 'package:deva_test/data/repositorys/base_api.dart';
import 'package:deva_test/models/security/login_model.dart';
import 'package:deva_test/models/security/sesion_model.dart';



class SecurityRepository{

  Future<SesionModel>login(LoginModel model) async {
    try{

      var response= await
      BaseApi.instance.dioPost<SesionModel>("/Auth/Login",SesionModel(), model.toMap());
      return response;
    }catch(e){
      throw e;
    }
  }



}
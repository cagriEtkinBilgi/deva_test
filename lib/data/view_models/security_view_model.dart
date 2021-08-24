import 'package:deva_test/data/repositorys/security_repository.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/security/login_model.dart';
import 'package:deva_test/models/security/sesion_model.dart';
import 'package:deva_test/tools/locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../error_model.dart';


class SecurityViewModel with ChangeNotifier {
  ApiStateEnum _state;
  SesionModel _sesionModel;
  ErrorModel _errorModel;

  ErrorModel get errorModel => _errorModel;
  SecurityRepository repo =locator<SecurityRepository>();


  SecurityViewModel(){
    _state=ApiStateEnum.initstate;
  }

  SesionModel get sesionModel => _sesionModel;

  set sesionModel(SesionModel value) {
    _sesionModel = value;
  }

  ApiStateEnum get state => _state;
  set state(ApiStateEnum value) {
    _state = value;
    notifyListeners();
  }

  Future<bool>Login(LoginModel model) async {
    state=ApiStateEnum.LodingState;
    var shrd= await SharedPreferences.getInstance();
    try{
      var sesionModel= await repo.login(model);
      print(sesionModel);
      if(sesionModel!=null){
        shrd.setString("token", sesionModel.toJson());
        shrd.setString("rememberMe", model.toJson());
        state=ApiStateEnum.LoadedState;//Giriş İşlemi İçin Hata Mesajı Yazılacak!!
        return true;
      }else{
        return false;
      }
    }catch(e){
      state=ApiStateEnum.ErorState;
      _errorModel=e;
      throw e;
    }
  }
  Future<bool> CurrentSesion() async {
    try{
      var shrd= await SharedPreferences.getInstance();
      var currendSesion=shrd.getString("rememberMe");
      if(currendSesion!=null){
        var loginModel=LoginModel().fromJson(currendSesion);
        var retVal= await Login(loginModel);//login istekleri kendini tekrarlıyor!!

        if(retVal!=null){
          return true;
        }else{
          return false;
        }

      }else{
        return false;
      }
    }catch(e){
      return false;
    }
  }

  Future<SesionModel> getCurrentSesion() async {
    try{
      var shrd= await SharedPreferences.getInstance();
      var currendSesion=shrd.getString("token");
      if(currendSesion!=null){
        sesionModel=SesionModel().fromJson(currendSesion);
        return sesionModel;
      }else{
        throw ErrorModel(message: "Sesion Hatası",onAuth: 0);
      }
    }catch(e){
      throw ErrorModel(message: e.toString(),onAuth: 0);
    }
  }
  Future<bool> Logout() async {
    try{
      var shrd= await SharedPreferences.getInstance();
      shrd.remove("rememberMe");
      return true;
    }catch(e){
      return false;
    }

  }





}

import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/security/login_model.dart';
import 'package:deva_test/tools/styles.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  var loginFormKey=GlobalKey<FormState>();
  var loginModel=LoginModel();
  SecurityViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    _viewModel=Provider.of<SecurityViewModel>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: gridBackgroundBox,
        child: SingleChildScrollView(
          child: Padding(
            padding:EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 120,
            ),
            child: Form(
              key: loginFormKey,
              child: Column(
                children: [
                  Text(
                      "Giriş",
                    style: formTitleStyle,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        decoration: inputBoxDecoration,
                        child: TextFormField(
                          validator: (val)=>FormValidations.UserNameValidation(val),
                          onChanged: (val){
                            loginModel.UserName=val;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              labelText: "Kullanıcı Adı",
                              border: InputBorder.none,
                              labelStyle: textStyle,
                              hintText: "Kullanıcı Adı",
                              hintStyle: hintTextStyle,
                              prefixIcon: Icon(Icons.person,color: Colors.white)
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        decoration: inputBoxDecoration,
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.white,
                          validator: (val)=>FormValidations.PasswordValidation(val),
                          onChanged: (val){
                            loginModel.Password=val;
                          },
                          decoration: InputDecoration(
                              labelText: "Şifre",
                              border: InputBorder.none,
                              labelStyle: textStyle,
                              hintText: "Şifre Giriniz",
                              hintStyle: hintTextStyle,
                              prefixIcon: Icon(Icons.vpn_key,color: Colors.white)
                          ),

                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: (){ debugPrint("Hop");},//Şifre Sıfırlama İşlemine gönderilecek
                          child: Text("Şifremi Unuttum!",style: textStyle,),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () async {
                            if(loginFormKey.currentState.validate()){
                              loginFormKey.currentState.save();
                              try{
                                await _viewModel.Login(loginModel).then((value){
                                  if(value){
                                      Navigator.of(context).pushReplacementNamed('/MainPage');
                                  }else{
                                    CustomDialog.instance.exceptionMessage(context,model: _viewModel.errorModel);
                                  }
                                });
                              }catch(e){
                                print(e);
                                CustomDialog.instance.exceptionMessage(context,model: _viewModel.errorModel);
                              }

                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.white,
                          child: buttonText(_viewModel.state),
                        ),

                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonText(ApiStateEnum state) {
    if(state==ApiStateEnum.initstate){
      return Text(
        "Giriş",
        style: raiseButtonTextStyle,
      );
    }else if(state==ApiStateEnum.ErorState){
      //hata mesajı yazılacak
      return Text(
        "Giriş",
        style: raiseButtonTextStyle,
      );
    }else if(state==ApiStateEnum.LodingState) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(backgroundColor: Colors.white,valueColor:AlwaysStoppedAnimation<Color>(Colors.blueAccent),),
      );
    }else{
      return Text(
        "Giriş",
        style: raiseButtonTextStyle,
      );
    }
  }
}

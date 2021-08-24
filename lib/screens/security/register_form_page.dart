import 'package:deva_test/components/district_dropdown_widget.dart';
import 'package:deva_test/components/neighborhood_dropdown_widget.dart';
import 'package:deva_test/components/provincial_dropdown_widget.dart';
import 'package:deva_test/models/FakeData/adress.dart';
import 'package:deva_test/models/addresses/provincial_model.dart';
import 'package:deva_test/models/security/register_model.dart';
import 'package:deva_test/tools/styles.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  var registerFormKey=GlobalKey<FormState>();
  var registerModel=RegisterModel();

  getProvincialID(int ID){
    debugPrint(ID.toString());
    registerModel.ProvincialID=ID;
    setState(() {

    });
  }
  getDistrictID(int ID){
    registerModel.DistrictID=ID;
    setState(() {

    });
  }
  getNeighborhood(int ID){
    registerModel.NeighborhoodID=ID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: gridBackgroundBox,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 120,
            ),
            child: Form(
              key: registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("Kayıt Ol",style: formTitleStyle,)),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: inputBoxDecoration,
                    child: TextFormField(
                      validator: (val)=>FormValidations.UserNameValidation(val),
                      onChanged: (val){
                        registerModel.UserName=val;
                      },
                      style: textStyle,
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
                    height: 7,
                  ),
                  Container(
                    decoration: inputBoxDecoration,
                    child: TextFormField(
                      cursorColor: Colors.white,
                      validator: (val)=>FormValidations.PasswordValidation(val),
                      onChanged: (val){
                        registerModel.Password=val;
                      },
                      obscureText: true,
                      style: textStyle,
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
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    decoration: inputBoxDecoration,
                    child: TextFormField(
                      cursorColor: Colors.white,
                      validator: (val)=>FormValidations.PasswordValidation(val),
                      onChanged: (val){
                        registerModel.PasswordRepeat=val;
                      },
                      style: textStyle,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Şifre Tekrar",
                          border: InputBorder.none,
                          labelStyle: textStyle,
                          hintText: "Şifre Giriniz",
                          hintStyle: hintTextStyle,
                          prefixIcon: Icon(Icons.vpn_key,color: Colors.white)
                      ),

                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    decoration: inputBoxDecoration,
                    child: TextFormField(
                      keyboardType:TextInputType.emailAddress,
                      cursorColor: Colors.white,
                      validator: (val)=>FormValidations.EmailValidation(val),
                      onChanged: (val){
                        registerModel.Email=val;
                      },
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: "Email",
                          border: InputBorder.none,
                          labelStyle: textStyle,
                          hintText: "Email Giriniz",
                          hintStyle: hintTextStyle,
                          prefixIcon: Icon(Icons.mail,color: Colors.white)
                      ),

                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    decoration: inputBoxDecoration,
                    child: TextFormField(
                      cursorColor: Colors.white,
                      validator: (val)=>FormValidations.NonEmty(val),
                      onChanged: (val){
                        registerModel.Name=val;
                      },
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: "Ad",
                          border: InputBorder.none,
                          labelStyle: textStyle,
                          hintText: "Ad Giriniz",
                          hintStyle: hintTextStyle,
                          prefixIcon: Icon(Icons.person_rounded,color: Colors.white)
                      ),

                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    decoration: inputBoxDecoration,
                    child: TextFormField(
                      cursorColor: Colors.white,
                      validator: (val)=>FormValidations.NonEmty(val),
                      onChanged: (val){
                        registerModel.Surname=val;
                      },
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: "Soyad",
                          border: InputBorder.none,
                          labelStyle: textStyle,
                          hintText: "Soyad Giriniz",
                          hintStyle: hintTextStyle,
                          prefixIcon: Icon(Icons.family_restroom,color: Colors.white)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    decoration: inputBoxDecoration,
                    child: TextFormField(
                      keyboardType:TextInputType.phone,
                      cursorColor: Colors.white,
                      validator: (val)=>FormValidations.PhoneValidation(val),
                      onChanged: (val){
                        registerModel.MobilePhone=val;
                      },
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: "Telefon",
                          border: InputBorder.none,
                          labelStyle: textStyle,
                          hintText: "Telefon Giriniz",
                          hintStyle: hintTextStyle,
                          prefixIcon: Icon(Icons.phone_android,color: Colors.white)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    decoration: inputBoxDecoration,
                    child: ProvincialDropdown(
                      onChange: getProvincialID,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    decoration: inputBoxDecoration,
                    child: DistrictDropdown(
                      ProvincialID: registerModel.ProvincialID,
                      onChange: getDistrictID,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    decoration: inputBoxDecoration,
                    child: NeighborhoodDropdown(
                      DistrictID: registerModel.DistrictID,
                      onChange: getNeighborhood,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25.0),
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: (){
                        if(registerFormKey.currentState.validate()){
                          registerFormKey.currentState.save();
                          debugPrint(registerModel.toJson()); //Apiye Gönderilecek
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Colors.white,
                      child: Text(
                        "Kayıt",
                        style: raiseButtonTextStyle,
                      ),
                    ),

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}

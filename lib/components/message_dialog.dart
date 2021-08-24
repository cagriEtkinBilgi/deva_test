import 'package:deva_test/data/error_model.dart';
import 'package:flutter/material.dart';

class CustomDialog{
  static CustomDialog _instance;
  static CustomDialog get instance{
    if(_instance==null)_instance=CustomDialog._init();
    return _instance;
  }
  CustomDialog._init();
  ErrorModel _errModel;


  void ErrorControl(ErrorModel model) {
    if(model!=null)
      _errModel=model;
    else
      _errModel.message="Bir Hata Oluştu";
      _errModel.errorStatus=1;
  }
   Future<bool> exceptionMessage(BuildContext context,{ErrorModel model}){
     ErrorControl(model);
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: getTitle(_errModel.errorStatus),
          content: Text(_errModel.message),
          actions: [
            FlatButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                  },
                child: Text("Tamam"),
            )
          ],
        );
      }
    );
  }

  Future<bool> InformDialog(BuildContext context,String title,String desc){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Text(desc),
            actions: [
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
                child: Text("Tamam"),
              )
            ],
          );
        }
    );
  }

  Future<bool> confirmeMessage(BuildContext context,{String title,String cont,String confirmBtnTxt="Evet",String unConfirmeBtnTxt="Hayır"}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(cont),
            actions: [
              FlatButton(
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
                child: Text(unConfirmeBtnTxt),
              ),
              FlatButton(
                onPressed: () {
                  return Navigator.of(context).pop(true);
                },
                child: Text(confirmBtnTxt),
              ),
            ],
          );
        }
    );
  }
  getTitle(int errorStatus) {
    if(errorStatus==2||errorStatus==3){
      return Text("Uyarı");
    }else{
      return Text("Hata");
    }
  }
}


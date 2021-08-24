import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/tools/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  SecurityViewModel _viewModel;
  bool send=true;
  @override
  Widget build(BuildContext context) {
    if(send){
      try{
        _viewModel=Provider.of<SecurityViewModel>(context);
         _viewModel.CurrentSesion().then((value){
          if(value){
            Navigator.of(context).pushReplacementNamed('/MainPage');
          }else{
            Navigator.of(context).pushReplacementNamed('/Login');
          }
        });
      }catch(e){
        Navigator.of(context).pushReplacementNamed('/Login');
        throw e;
      }
      send=false;
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: gridBackgroundBox,
      child: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white,),
      ),
    );
  }
}

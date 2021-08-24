import 'package:deva_test/data/error_model.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  ErrorModel _model;
  CustomErrorWidget(this._model);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: getTitle(_model.errorStatus),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_model.message),
            ],
          )

      ),
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

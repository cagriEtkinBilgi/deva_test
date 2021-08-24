import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/components/text_field_date_time_picker_widget.dart';
import 'package:deva_test/data/view_models/activity_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:flutter/material.dart';

class ActivityCompleteForm extends StatelessWidget {
  var _activityCompleteForm=GlobalKey<FormState>();
  int id;
  ActivityCompleteForm({Map args}){
    if(args["id"]!=null)
      id=args["id"];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faaliyet Tamamla"),
      ),
      body:buildScreen(id),
    );
  }
  Widget buildScreen(int id){
    return BaseView<ActivityViewModel>(
      onModelReady: (model){
        model.getActivityComplateForm(id);
      },
      builder: (context,model,widget){
        if(model.apiState==ApiStateEnum.LodingState)
          return ProgressWidget();
        else if(model.apiState==ApiStateEnum.LoadedState)
          return buildCompleteForm(context, model);
        else
          return CustomErrorWidget(model.onError);
      },
    );
  }

  Widget buildCompleteForm(BuildContext context,ActivityViewModel model){
    var _formModel=model.completeFormModel;
    _formModel.id=id;
   return Card(
     child: Padding(
       padding: const EdgeInsets.all(4.0),
       child: SingleChildScrollView(
         child: Container(
           child: Form(
             key: _activityCompleteForm,
             child: Column(
               children: [
                 TextFormField(
                   validator: (val)=>FormValidations.NonEmty(val),
                   onChanged: (val){
                     _formModel.summary=val;
                   },
                   initialValue:_formModel.summary,
                   decoration: InputDecoration(
                     labelText: "Özet",
                     hintText: "Faaliyet Özeti",
                   ),
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 TextFormField(
                   validator: (val)=>FormValidations.NonEmty(val),
                   onChanged: (val){
                     _formModel.returns=val;
                   },
                   initialValue:_formModel.returns,
                   decoration: InputDecoration(
                     labelText: "Sonuç",
                     hintText: "Faaliyet Sonucu",
                   ),
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 TextFieldDateTimePickerWidget(
                   initDate: _formModel.startDateStr,
                   initTimeStr: _formModel.startTime,
                   dateLabel: "Başlangıç Tarihi",
                   timeLabel: "Saat",
                   onChangedDate: (date,time){
                     _formModel.startDateStr=date;
                     _formModel.startTime=time;
                   },
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 TextFieldDateTimePickerWidget(
                   initDate: _formModel.endDateStr,
                   initTimeStr: _formModel.endTime,
                   dateLabel: "Bitiş Tarihi",
                   timeLabel: "Saat",
                   onChangedDate: (date,time){
                     _formModel.endDateStr=date;
                     _formModel.endTime=time;
                   },
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 Container(
                   width: double.infinity,
                   child: RaisedButton(
                     onPressed: () async {
                       try{
                         print(_formModel.toJson());
                         await model.completeActivity(_formModel).then((value){
                           if(value){
                             Navigator.of(context).pop(true);
                           }else{
                             CustomDialog.instance.exceptionMessage(context);
                           }
                         });
                       }catch(e){
                         CustomDialog.instance.exceptionMessage(context,model: e);
                       }
                     },
                     color: Colors.blue,
                     child: Text("Kaydet"),
                   ),
                 )
               ],
             ),
           ),
         ),
       ),
     ),
   );
  }

}

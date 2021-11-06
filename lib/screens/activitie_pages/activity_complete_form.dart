import 'package:deva_test/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/location_components/location_text_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/components/date_components/text_field_date_time_picker_widget.dart';
import 'package:deva_test/data/view_models/activity_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/component_models/check_list_model.dart';
import 'package:deva_test/models/component_models/select_list_widget_model.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'activiti_layouts/activity_complate_participants_widget.dart';

class ActivityCompleteForm extends StatelessWidget {
  var _activityCompleteForm=GlobalKey<FormState>();
  int id;
  List<CheckListModel> listParticipants;
  ActivityCompleteForm({Map args}){
    if(args["id"]!=null)
      id=args["id"];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faaliyet Tamamla"),
        flexibleSpace: FlexibleSpaceBackground(),
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
                 LocationTextWidget(
                   initVal: "",
                   onChange: (val){
                     _formModel.locationName=val;
                   },
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 ActivityComplateParticipantsWidget(
                   futureInvadedUser:model.getInvadedUser(id),
                   futureParticipant:model.getParticipantsUser(id),
                   onSaveInvadedAsyc:(List<CheckListModel> checks) async {
                     try{
                       var retval=await await model.addUserToActivity(checks, id);
                       model.setState(ApiStateEnum.LoadedState);
                       return retval;
                     }catch(e){
                       throw e;
                     }

                   },
                   onChangeStatus: (List<SelectListWidgetModel> val){
                     listParticipants=val.map((e) => e.toCheckListModel()).toList();
                   },
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 Container(
                   width: double.infinity,
                   child: ElevatedButton(
                     onPressed: () async {
                       if(!_activityCompleteForm.currentState.validate()){
                         return;
                       }
                       if(listParticipants.length<=0){
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                           content: Text("Lütfen Yoklamayı Yapın"),
                         ));
                         return;
                       }

                       try{
                         await model.completeActivity(_formModel,listParticipants).then((value){
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

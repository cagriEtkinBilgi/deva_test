import 'package:deva_test/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/custom_link_field_widget.dart';
import 'package:deva_test/components/dropdown_serach_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/form_checkbox_list_tile_Widget.dart';
import 'package:deva_test/components/location_select_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/components/date_components/text_field_date_time_picker_widget.dart';
import 'package:deva_test/data/view_models/activity_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:flutter/material.dart';

class ActivityFormPage extends StatelessWidget {
  int id;
  int workGroupId;
  String title;
  var _activityForm=GlobalKey<FormState>();
 
  ActivityFormPage({Map args}){
    if(args["id"]!=null)
      id=args["id"];
    if(args["title"]!=null)
      title=args["title"];
    workGroupId=args["workGroupId"];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (title!=null)?Text("$title -  Güncelle"):Text("Yeni Faaliyet"),
        flexibleSpace: FlexibleSpaceBackground(),
      ),
      body: buildScrean(workGroupId),
    );
  }

  Widget buildScrean(int workId){
    return BaseView<ActivityViewModel>(
      onModelReady: (model){
        model.getActivityForm(id);
      },
      builder: (context,model,widget){
        if(model.apiState==ApiStateEnum.LodingState)
          return ProgressWidget();
        else if(model.apiState==ApiStateEnum.LoadedState)
          return buildForm(context, model,workId);
        else
          return CustomErrorWidget(model.onError);
      },
    );
  }


  Widget buildForm(context,ActivityViewModel model,int workId) {
    var form=model.formModel;
    form.workGroupID=workId;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          child: Form(
            key: _activityForm,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val)=>FormValidations.NonEmty(val),
                      onChanged: (val){
                        form.name=val;
                      },
                      initialValue:form.name,
                      decoration: InputDecoration(
                        labelText: "Faaliyet Adı",
                        hintText: "Faaliyet Adı",
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val)=>FormValidations.NonEmty(val),
                      onChanged: (val){
                        form.desc=val;
                      },
                      initialValue: form.desc,
                      decoration: InputDecoration(
                        labelText: "Faaliyet Açıklama",
                        hintText: "Faaliyet Açıklama",
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val)=>FormValidations.NonEmty(val),
                      onChanged: (val){
                        form.locationName=val;
                      },
                      initialValue:form.locationName,
                      decoration: InputDecoration(
                        labelText: "Faaliyet Konumu",
                        hintText: "Faaliyet Konumu",
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DropdownSerachWidget(
                      selectedId: form.activityTypeID,
                      items: model.formModel.categorySelects,
                      dropdownLabel: " Faaliyet Kategorisi",
                      onChange: (val){
                        form.activityTypeID=val.id;
                      },
                    ),
                    Divider(color: Colors.black,),
                    SizedBox(
                      height: 5,
                    ),
                    TextFieldDateTimePickerWidget(
                      initDate: form.plannedStartDateStr,
                      initTimeStr: form.plannedStartTime,
                      dateLabel: "Başlangıç Tarihi",
                      timeLabel: "Saat",
                      onChangedDate: (date,time){
                        form.plannedStartDateStr=date;
                        form.plannedStartTime=time;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFieldDateTimePickerWidget(
                      initDate: form.plannedEndDateStr,
                      initTimeStr: form.plannedEndTime,
                      dateLabel: "Bitiş Tarihi",
                      timeLabel: "Saat",
                      onChangedDate: (date,time){
                        form.plannedEndDateStr=date;
                        form.plannedEndTime=time;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FormCheckboxListTile(
                      title: "Herkese Açık",
                      initVal: form.isPublic,
                      onChangedSelection: (retVal){
                        form.isPublic=retVal;
                      },
                    ),
                    FormCheckboxListTile(
                      title: "Üst Birim İle Birlikte",
                      initVal: form.isWithUpperUnit,
                      onChangedSelection: (retVal){
                        form.isWithUpperUnit=retVal;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomLinkFileldWidget(
                      isOnline: form.isOnline,
                      Url: form.inviteLink,
                      chcTitle: "Çevrim İçi mi?",
                      onChangeStatus: (val){
                        form.isOnline=val['isOnline'];
                        form.inviteLink=val['url'];
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    LocationSelectWidget(
                      initDate: form.dueDateStr,
                      onChange: (id,date){
                        form.dueDateStr=date;
                        form.repetitionType=id;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          try{
                            await model.createActivity(form).then((value){
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
                        //style: ButtonStyle(
                          //  backgroundColor: MaterialStateProperty.all(Colors.blue)
                        //),
                        child: Text("Kaydet"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}

import 'package:deva_test/components/custom_link_field_widget.dart';
import 'package:deva_test/components/form_checkbox_list_tile_Widget.dart';
import 'package:deva_test/components/location_components/location_text_widget.dart';
import 'package:deva_test/components/date_components/text_field_date_time_picker_widget.dart';
import 'package:deva_test/models/activity_models/activity_form_model.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:flutter/material.dart';

class ActivityCreateFormWidget extends StatelessWidget {
  GlobalKey<FormState> activityForm;
  ActivityFormModel form;

  ActivityCreateFormWidget({this.form,this.activityForm});
  @override
  Widget build(BuildContext context){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          child: Form(
              key: activityForm,
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
                          form.returns=val;
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
                          form.summary=val;
                        },
                        initialValue:form.locationName,
                        decoration: InputDecoration(
                          labelText: "Özet",
                          hintText: "Özet",
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //Bu Alan Kalkacak Ve Telefon Konumu Alınacak
                      LocationTextWidget(
                        initVal: form.locationName,
                        onChange: (val){
                          form.locationName=val;
                        },
                      ),
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

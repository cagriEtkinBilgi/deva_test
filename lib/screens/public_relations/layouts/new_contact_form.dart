import 'package:deva_test/components/address_components/adress_district_dropdown_component.dart';
import 'package:deva_test/components/date_components/text_field_date_picker_widget.dart';
import 'package:deva_test/components/dropdown_serach_widget.dart';
import 'package:deva_test/components/radiobutons/member_radio_buttons.dart';
import 'package:deva_test/models/component_models/dropdown_search_model.dart';
import 'package:deva_test/models/public_relation_models/new_contact_form_model.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class NewContactForm extends StatelessWidget {
  GlobalKey<FormState> formKey;
  NewContactFormModel form;
  List<DropdownSearchModel> districtes;
  List<DropdownSearchModel> jops;

  Future<List<DropdownSearchModel>> Function(int DistrictId) getNeighborhood;
  var phoneMask=new MaskTextInputFormatter(mask: '(###) ### ## ##' , filter: { "#": RegExp(r'[0-9]') });
  NewContactForm({
    Key key,
    this.formKey,
    this.form,
    this.districtes,
    this.getNeighborhood,
    this.jops,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          child: Form(
            key:formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MemberRadioButton(
                    value: 0,
                    onClick: (val){
                      form.userStatus=val;
                    },
                  ),
                  TextFormField(
                    validator: (val)=>FormValidations.NonEmty(val),
                    onChanged: (val){
                      form.name=val;
                    },
                    initialValue:form.name,
                    decoration: InputDecoration(
                      labelText: "Ad",
                      hintText: "Ad",
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (val)=>FormValidations.NonEmty(val),
                    onChanged: (val){
                      form.surName=val;
                    },
                    initialValue:form.surName,
                    decoration: InputDecoration(
                      labelText: "Soyad",
                      hintText: "Soyad",
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (val)=>FormValidations.identityNumberValidation(val),
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      form.identityNumber=val;
                    },
                    initialValue:form.identityNumber,
                    decoration: InputDecoration(
                      labelText: "TC Kimlik No",
                      hintText: "TC Kimlik No",
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [phoneMask],
                    validator: (val)=>FormValidations.NonEmty(val),
                    onChanged: (val){
                      form.mobilePhone =phoneMask.getUnmaskedText();
                    },
                    decoration: InputDecoration(
                      labelText: "Telefon No",
                      hintText: "(555) 444 33 22",
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (val)=>FormValidations.NonEmty(val),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val){
                      form.email=val;
                    },
                    initialValue:form.email,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(height: 5,),
                  TextFieldDatePickerWidget(
                    dateLabel:"Doğum Tarihi",
                    onChangedDate: (val){
                      form.birthDate=val;
                    },
                  ),
                  SizedBox(height: 5,),
                  DropdownSerachWidget(
                    items: AppTools.getGender(),
                    dropdownLabel: "Cinsiyet",
                    onChange: (val){
                      print(val.id);
                      form.gender=val.id;
                    },
                  ),

                  SizedBox(height: 5,),
                  DropdownSerachWidget(
                    items: jops,
                    dropdownLabel: "Meslek",
                    onChange: (val){
                      print(val.id);
                      form.jobID=val.id;
                    },
                  ),
                  SizedBox(height: 5,),
                  DropdownSerachWidget(
                    items: AppTools.getEducationState(),
                    dropdownLabel: "Eğitim Durumu",
                    onChange: (val){
                      print(val.id);
                      form.educationState=val.id;
                    },
                  ),
                  SizedBox(height: 5,),
                  AddressDistrictDropdownComponent(
                    districtes: districtes,
                    getNeighborhood: getNeighborhood,
                    onChange: (val){
                      form.districtID=val.districtId;
                      form.neighborhoodID=val.neighborhoodId;
                    },
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

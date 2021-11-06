import 'package:deva_test/components/address_components/address_dropdown_component.dart';
import 'package:deva_test/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/dropdown_serach_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/form_checkbox_list_tile_Widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/components/date_components/text_field_date_picker_widget.dart';
import 'package:deva_test/data/view_models/public_relation_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
class AddNewRelationPage extends StatelessWidget {
  var relationForm=GlobalKey<FormState>();
  var contackForm=GlobalKey<FormState>();
  var checkNumberForm=GlobalKey<FormState>();
  var phoneMask=new MaskTextInputFormatter(mask: '(###) ### ## ##', filter: { "#": RegExp(r'[0-9]') });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gönüllü Ekle"),
        flexibleSpace: FlexibleSpaceBackground(),
      ),
      body: buildScreen(),
    );
  }
  Widget buildScreen() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color:Colors.grey.shade300
      ),
      child: SingleChildScrollView(
        child: BaseView<PublicRelationViewModel>(
          onModelReady: (model){
            model.pageReady();
            //model.getUserByPhoneNumber(phoneNumber);
          },
          builder: (context,model,widget){
            if(model.apiState==ApiStateEnum.LodingState)
              return Center(child: ProgressWidget());
            else if(model.apiState==ApiStateEnum.LoadedState)
              return buildCardColums(context,model);
            else
              return CustomErrorWidget(model.onError);
          },
        ),
      ),
    );
  }
  Widget buildCardColums(BuildContext context,PublicRelationViewModel model){
    return Column(
      children: [
        buildCheckPhoneNumberForm(context, model),
        Visibility(
          visible: model.showResult,
          child: buildResultCard(context, model))
      ],
    );
  }

  Widget buildCheckPhoneNumberForm(BuildContext context, PublicRelationViewModel model) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Form(
          key: checkNumberForm,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [phoneMask],
                validator: (val)=>FormValidations.NonEmty(val),
                onChanged: (val){
                  model.phoneNumber=phoneMask.getMaskedText();
                },
                decoration: InputDecoration(
                  labelText: "Telefon No",
                  hintText: "(555) 444 33 22",
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () async {
                    try{
                      if(!checkNumberForm.currentState.validate())
                        return;
                      await model.getUserByPhoneNumber();
                    }catch(e){
                      CustomDialog.instance.exceptionMessage(context,model: e);
                    }
                  },
                  color: Colors.blue,
                  child: Text("Sorgula",style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResultCard(BuildContext context,PublicRelationViewModel model) {
    if(model.showUserCard){
      return Card(
        child: Column(
          children: [
            ListTile(
              title: Text("Ad Soyad"),
              subtitle: Text(model.checkedModel.name+" "+model.checkedModel.surname),
              trailing: Icon(Icons.person),
            ),
            builForm(context,model),
          ],

        ),
      );
    }else {
      return Card(
        child: Container(
          child: builForm(context,model),
        ),
      );
    }
  }
  Widget builForm(BuildContext context, PublicRelationViewModel model){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Form(
        key: contackForm,
        child: Column(
          children: [
            Visibility(
              visible: !model.showUserCard,
              child:Column(
                children: [
                  TextFormField(
                    validator: (val)=>FormValidations.NonEmty(val),
                    inputFormatters: [phoneMask],
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      model.createModel.phoneNumber=phoneMask.getMaskedText();
                    },
                    initialValue:model.createModel.phoneNumber??"",
                    decoration: InputDecoration(
                      labelText: "Telefon Numarası",
                      hintText: "Telefon Numarası",
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (val)=>FormValidations.NonEmty(val),
                    onChanged: (val){
                      model.createModel.name=val;
                    },
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
                      model.createModel.surname=val;
                    },
                    decoration: InputDecoration(
                      labelText: "Soyad",
                      hintText: "Soyad",
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (val)=>FormValidations.NonEmty(val),
                    onChanged: (val){
                      model.createModel.email=val;
                    },
                    decoration: InputDecoration(
                      labelText: "E-Mail",
                      hintText: "E-Mail",
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DropdownSerachWidget(
                    items: AppTools.getGender(),
                    dropdownLabel: "Cinsiyet",
                    onChange: (val){
                      model.createModel.gender=val.id;
                    },
                  ),
                  AddressDropdownComponent(
                    providences: model.createModel.provinceSelectList,
                    getDistrict: (id)=>model.getDistrict(id),
                    getNeighborhood: (id)=>model.getNeighborhood(id),
                    onChange: (valModel){
                      model.createModel.provinceId=valModel.providenceId;
                      model.createModel.districtId=valModel.districtId;
                      model.createModel.neighborhoodId=valModel.neighborhoodId;
                    },
                  ),
                ],
              )
            ),

            Divider(color: Colors.black,),
            SizedBox(
              height: 5,
            ),
            DropdownSerachWidget(
              items: model.createModel.unitSelectList,
              dropdownLabel: "Birim",
              onChange: (val){
                model.createModel.unitId=val.id;
              },
            ),
            DropdownSerachWidget(
              items: model.createModel.userSelectList,
              dropdownLabel: "İlgili Kişi",
              onChange: (val){
                model.createModel.userId=val.id;
              },
            ),
            DropdownSerachWidget(
              items: model.createModel.eventSelectList,
              dropdownLabel: "Olay Türü",
              onChange: (val){
                model.createModel.eventTypeId=val.id;
              },
            ),
            TextFormField(
              validator: (val)=>FormValidations.NonEmty(val),
              onChanged: (val){
                model.createModel.request=val;
              },
              decoration: InputDecoration(
                labelText: "İsteği",
                hintText: "İsteği",
              ),
            ),
            TextFormField(
              onChanged: (val){
                model.createModel.desc=val;
              },
              decoration: InputDecoration(
                labelText: "Açıklama",
                hintText: "Açıklama",
              ),
            ),
            FormCheckboxListTile(
              title: "Geri Dönüş Gerekli mi?",
              onChangedSelection: (val){
                model.createModel.isNeedCallback=val;
              },
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () async {
                  if(!contackForm.currentState.validate())
                    return;
                  try{
                    await model.addPublicRelation().then((value){
                      if(value){
                        CustomDialog.instance.InformDialog(context,"Bilgilendirme","Kayıtbaşarılı");
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
    );

  }
}


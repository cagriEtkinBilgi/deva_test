import 'package:deva_test/components/address_components/adress_district_dropdown_component.dart';
import 'package:deva_test/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/check_list_components/multiple_image_select_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/data/view_models/conatct_view_model.dart';
import 'package:deva_test/data/view_models/public_relation_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/component_models/attachment_dialog_model.dart';
import 'package:deva_test/models/public_relation_models/contact_attacment_post_model.dart';
import 'package:deva_test/models/public_relation_models/contact_phone_confirme_model.dart';
import 'package:deva_test/models/public_relation_models/new_contact_form_model.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/locator.dart';
import 'package:flutter/material.dart';

import 'layouts/new_contact_form.dart';
import 'layouts/phone_confirme_layout.dart';
class AddNewContact extends StatefulWidget {
  const AddNewContact({Key key}) : super(key: key);

  @override
  _AddNewContactState createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  int _currentStep=0;
  String _smsToken="";
  String _textToken="";
  int _recortID=0;
  List<AttachmentDialogModel> images;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  NewContactFormModel form=NewContactFormModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gönüllü Ekle"),
        flexibleSpace: FlexibleSpaceBackground(),
      ),
      body:buildScreen(),
    );
  }



  Stepper buildScreen() {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _currentStep,
      onStepTapped: (step) => tapped(step),
      onStepContinue:continued,
      onStepCancel: cancel,
      controlsBuilder: (BuildContext context,{void Function() onStepCancel, void Function() onStepContinue}){
        return buildControls(onStepContinue, onStepCancel,context);
      },
      steps: <Step>[
        Step(
          title: (_currentStep == 0)? Text('Bilgiler'):Text('...'),
          content:BaseView<ContactViewModel>(
          onModelReady: (model){
            model.getContactDistrict();
          },
          builder: (context,model,widget){
            if(model.apiState==ApiStateEnum.LodingState)
              return Center(child: ProgressWidget());
            else if(model.apiState==ApiStateEnum.LoadedState)
              return Column(
              children: [
                NewContactForm(
                  formKey: formKey,
                  form: form,
                  jops: model.jops,
                  districtes: model.distinc,
                  getNeighborhood: model.getNeighborhood,
                ),
                ],
              );
            else
            return CustomErrorWidget(model.onError);
            },
          ),
          isActive:_currentStep >= 0,
          state: _currentStep >= 2 ?
          StepState.complete : StepState.disabled,
        ),

        Step(
          title: (_currentStep == 1)? Text('Doğrulama'):Text('..'),
          content: PhoneConfirmeLayout(
            onChangeText:(String val){
              if(val!="")
                _textToken=val.trim();
            },
            onReSend: (){
              var model=locator<ContactViewModel>();
              model.resendSmsToken(_recortID).then((value){
                if(value!=null){
                  _smsToken=value.smsToken;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SMS Talep Edildi")));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bir Hata Oluştu Lütfen Tekrar Deneyin")));
                }
              });
            },
          ),
          isActive:_currentStep >= 0,
          state: _currentStep >= 2 ?
          StepState.complete : StepState.disabled,
        ),
        Step(
          title: (_currentStep == 2)? Text('Resim Ekle'):Text('..'),
          content: MultipleImageSelectWidget(
            images: [],
            onChange: (val){
              images=val;
            },
          ),
          isActive:_currentStep >= 0,
          state: _currentStep >= 2 ?
          StepState.complete : StepState.disabled,
        ),
      ]
  );
  }

  Widget buildControls(void onStepContinue(), void onStepCancel(),BuildContext context) {
    return BaseView<ContactViewModel>(
      onModelReady: (model){
        //model.loadForm();
      },
      builder: (context,model,widget){
        if(model.apiState==ApiStateEnum.LodingState)
          return Center(child: ProgressWidget());
        else if(model.apiState==ApiStateEnum.LoadedState)
          return Row(
            children: [
              TextButton(onPressed:() {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("İşlem İptal Edildi! Sonra Devam Edebilirsini!")));
                Navigator.pop(context);
                } , child: Text("İptal")
              ),
              Spacer(),
              Visibility(
                visible: (_currentStep==1),
                child: TextButton(onPressed:() {
                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("İşlem İptal Edildi! Sonra Devam Edebilirsini!")));

                  onStepContinue();
                } , child: Text("Atla")
                ),
              ),
              SizedBox(width: 5,),
              TextButton(
                onPressed:() async {
                  try{
                    if(_currentStep==0){
                      if(formKey.currentState.validate()){

                        var value= await model.addContact(form);
                        if(value!=null){
                          _smsToken=value.smsToken;
                          print(_smsToken);
                          _recortID=value.id;
                          onStepContinue();
                        }
                        else
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bir Hata Oluştu")));
                      }
                    }
                    else if(_currentStep==1){

                      if(_textToken==_smsToken){
                        var smsModel= ContactPhoneConfirmeModel(id:_recortID,smsToken: _smsToken );
                        var value= await model.confirmeMobilePhone(smsModel);
                        if(value){
                          onStepContinue();
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Doğrulama Kodu Hatası")));
                      }

                    }else{

                      var imageModels=ContactAttacmentPostModel(
                        Images: images,
                        id: _recortID,
                      );
                      await model.addImagesContact(imageModels).then((value){
                        if(value){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kayıt İşlemi Başarılı")));
                          Navigator.pop(context);


                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kayıt Sırasında Bir Hata Oldu")));
                        }
                      });

                    }
                  }catch(e){
                    CustomDialog.instance.exceptionMessage(context,model: e);
                  }
                  //onStepContinue();
                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("En Az Bir Katılımcı Seçniz")));

                },
                child: Text("Devam"),
              ),

            ],
          );
        else
          return CustomErrorWidget(model.onError);
      },
    );

  }


  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }










}

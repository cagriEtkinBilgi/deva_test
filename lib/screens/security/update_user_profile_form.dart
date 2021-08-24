import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/images_components/image_select_component.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/data/view_models/profile_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UpdateUserProfileForm extends StatelessWidget {

  int id=0;
  var profilForm=GlobalKey<FormState>();
  var phoneMask=new MaskTextInputFormatter(mask: '(###) ### ## ##', filter: { "#": RegExp(r'[0-9]') });
  UpdateUserProfileForm({Map args}){
    if(args!=null)
      if(args["id"]!=null)
        id=args["id"];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Güncelle"),
      ),
      body: buildScreen(),
    );
  }

  Widget buildScreen(){
    return BaseView<ProfileViewModel>(
      onModelReady: (model){
        model.pageReady(id);
      },
      builder: (context,model,widget){
        if(model.apiState==ApiStateEnum.LodingState)
          return Center(child: ProgressWidget());
        else if(model.apiState==ApiStateEnum.LoadedState){
          return buildForm(context,model);
        }
        else
          return CustomErrorWidget(model.onError);
      },
    );
  }

  Widget buildForm(BuildContext context, ProfileViewModel model) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: ImageSelectComponents(
                url: model.profile.profileImage,
                onChange: (retVal){
                  model.profile.fileName=retVal.fileName;
                  model.profile.file=retVal.file;
                  model.profile.url=retVal.url;
                },
              ),
            ),
          )
        ),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Form(
              key: profilForm,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val)=>FormValidations.NonEmty(val),
                      onChanged: (val){
                        model.profile.name=val;
                      },
                      initialValue:model.profile.name,
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
                        model.profile.surname=val;
                      },
                      initialValue:model.profile.surname,
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
                      inputFormatters: [phoneMask],
                      keyboardType: TextInputType.number,
                      onChanged: (val){
                        model.profile.phoneNumber=phoneMask.getMaskedText();
                      },
                      initialValue:model.profile.phoneNumber,
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
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val){
                        model.profile.email=val;
                      },
                      initialValue:model.profile.email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () async {
                          try{

                            await model.updateProfile().then((value){
                              if(value){
                                Navigator.of(context).pop(true);
                              }else{
                                CustomDialog.instance.exceptionMessage(context);
                              }
                            });
                          }catch(e){
                            CustomDialog.instance.exceptionMessage(context,model: e);
                          }
                          model.profile.fileName=null;
                          model.profile.file=null;
                          model.profile.url=null;
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
        )
      ],
    );
  }
}

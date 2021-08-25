import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/components/check_list_components/selected_list_widget.dart';
import 'package:deva_test/data/view_models/activity_create_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/activity_models/activity_form_model.dart';
import 'package:deva_test/models/component_models/select_list_widget_model.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';
import 'activiti_layouts/activity_create_form_widget.dart';

class ActivityCreatePage extends StatefulWidget {
  const ActivityCreatePage({Key key}) : super(key: key);

  @override
  _ActivityCreatePageState createState() => _ActivityCreatePageState();
}

class _ActivityCreatePageState extends State<ActivityCreatePage> {
  int _currentStep = 0;
  bool _canEnd=false;
  List<SelectListWidgetModel> workGroupSelectList;
  List<SelectListWidgetModel> categoriSelectList;
  var form=ActivityFormModel();
  @override
  void initState() {
    form.repetitionType=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Faaliyet Oluştur'),
      ),
      body:  Stepper(
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
            title:(_currentStep == 0)? Text('Çalışma Grubu'):Text('...'),
            content:BaseView<ActivityCreateViewModel>(
              onModelReady: (model){
                model.getActivityWorkGroup();
              },
              builder: (context, model, child){
                if (model.apiState == ApiStateEnum.LodingState) {
                  return ProgressWidget();
                } else if (model.apiState == ApiStateEnum.ErorState) {
                  return CustomErrorWidget(model.onError);
                } else {
                  if(workGroupSelectList==null)
                    workGroupSelectList=model.workGroupSelectList;
                  return SelectedListWidget(
                    title: "Çalışma Gurubu Seç",
                    multiple: false,
                    items: workGroupSelectList,
                    onChangeStatus: (List<SelectListWidgetModel> val){
                      form.workGroupID=val.first.id;
                      ///print(val.toString());//değerler alındı obje oladar
                    },
                  );
                }
              },
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0 ?
            StepState.complete : StepState.disabled,
          ),
          Step(
            title:(_currentStep == 1 )? Text('Kategori'):Text('..'),
            content:Container(
              child: BaseView<ActivityCreateViewModel>(
                onModelReady: (model){
                  if(categoriSelectList==null){
                    model.getActivityActivityCategori();
                  }else
                    model.setLoaded();
                },
                builder: (context, model, child){
                  if (model.apiState == ApiStateEnum.LodingState) {
                    return ProgressWidget();
                  } else if (model.apiState == ApiStateEnum.ErorState) {
                    return CustomErrorWidget(model.onError);
                  } else {
                    if(categoriSelectList==null)
                      categoriSelectList=model.categoriSelectList;
                    return SelectedListWidget(
                      title: "Kategori Seç",
                      multiple: false,
                      items: categoriSelectList,
                      onChangeStatus: (List<SelectListWidgetModel> val){
                        form.activtyCategoryID=val.first.id;
                        form.activityTypeID=val.first.id;
                        ///print(val.toString());//değerler alındı obje oladar
                      },
                    );
                  }
                },
              ),
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 1 ?
            StepState.complete : StepState.disabled,
          ),
          Step(
            title: (_currentStep == 2)? Text('Durum Bilgileri'):Text('..'),
            content: ActivityCreateFormWidget(
              form: form,
            ),
            isActive:_currentStep >= 0,
            state: _currentStep >= 2 ?
            StepState.complete : StepState.disabled,
          ),
          Step(
            title: (_currentStep == 3)? Text('Katılımcılar'):Text('..'),
            content:BaseView<ActivityCreateViewModel>(
              onModelReady: (model){
                model.getActivityActivityParticipant(form.workGroupID);
              },
              builder: (context, model, child){
                if (model.apiState == ApiStateEnum.LodingState) {
                  return ProgressWidget();
                } else if (model.apiState == ApiStateEnum.ErorState) {
                  return CustomErrorWidget(model.onError);
                } else {
                  return SelectedListWidget(
                    title: "Katılımcı Seç",
                    multiple: true,
                    items: model.participantSelectList,
                    onChangeStatus: (List<SelectListWidgetModel> val){
                      List<int> idList=[];
                      for(var item in val){
                        idList.add(item.id);
                      }
                      form.participants=idList;
                      //print(form.activityParticipant);//değerler alındı obje oladar
                    },
                  );
                }
              },
            ),
            isActive:_currentStep >= 0,
            state: _currentStep >= 3 ?
            StepState.complete : StepState.disabled,
          ),
        ],
      ),
    );
  }

  Row buildControls(void onStepContinue(), void onStepCancel(),BuildContext context) {
    return Row(
      children: [
        TextButton(onPressed: onStepCancel , child: Text("Geri")),
        Spacer(),
        Visibility(
          child: TextButton(
            onPressed:(){
              print(form.workGroupID);
              if(_currentStep==0){
                if(form.workGroupID!=null)
                  onStepContinue();
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lütfen Çalışma Grubu Seçin")));
                }
              }else if(_currentStep==1){
                if(form.activtyCategoryID!=null)
                  onStepContinue();
                else
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lütfen Kategori Seçin")));
              }else if(_currentStep==2){
                if(form.name!=null)
                  onStepContinue();
                else
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lütfen Formu Kotrol Ediniz")));
              }else if(_currentStep==3){
                if(form.participants.length!=0)
                  onStepContinue();
                else
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("En Az Bir Katılımcı Seçniz")));
              }

            },
            child: Text("Devam"),
          ),
          visible: !_canEnd,
        ),
        Visibility(
          child: BaseView<ActivityCreateViewModel>(
            onModelReady: (model){
              model.setLoaded();
            },
            builder: (context, model, child){
              if (model.apiState == ApiStateEnum.LodingState) {
                return ProgressWidget();
              } else if (model.apiState == ApiStateEnum.ErorState) {
                return CustomErrorWidget(model.onError);
              } else {
                return TextButton(
                  onPressed:()async{
                    try{
                      var result = await model.createActivity(form).then((value){
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
                  child: Text("Kaydet")
                );
              }
            },
          ),
          visible: _canEnd,
        ),
      ],
      );
    }


  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){

    _currentStep < 3 ?
    setState(() => _currentStep += 1): null;
    _canEnd=_currentStep==3;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
    _canEnd=_currentStep==3;
  }
}

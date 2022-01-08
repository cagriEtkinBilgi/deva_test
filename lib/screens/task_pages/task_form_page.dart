import 'package:deva_test/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/dropdown_serach_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/components/date_components/text_field_date_picker_widget.dart';
import 'package:deva_test/data/view_models/task_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:flutter/material.dart';

class TaskFormPage extends StatelessWidget {

  int id;
  int activityId;
  String title;
  var taskForm=GlobalKey<FormState>();

  TaskFormPage({Map args}){
    if(args!=null){
      this.id=args["id"];
      this.title=args["title"];
      this.activityId=args["activityId"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (title!=null)?Text("$title -  Güncelle"):Text("Yeni Aksiyon"),
        flexibleSpace: FlexibleSpaceBackground(),
      ),
      body:buidScrean(),
    );
  }

  Widget buidScrean() {
    return BaseView<TaskViewModel>(
      onModelReady: (model){
        model.getTaskForm(id);
      },
      builder: (context,model,widget){
        if(model.apiState==ApiStateEnum.LodingState)
          return ProgressWidget();
        else if(model.apiState==ApiStateEnum.LoadedState)
          return buildForm(context, model);
        else
          return CustomErrorWidget(model.onError);
      },
    );
  }

  Widget buildForm(BuildContext context, TaskViewModel model) {
    var formModel=model.task;
    formModel.activityID=activityId;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          key: taskForm,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (val)=>FormValidations.NonEmty(val),
                    onChanged: (val){
                      formModel.name=val;
                    },
                    initialValue:formModel.name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.content_paste),
                      labelText: "Görev Adı",
                      hintText: "Görev Adı",
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  TextFieldDatePickerWidget(
                    initDate: formModel.plannedEndDate,
                    dateLabel: "Hedef Tarih",
                    onChangedDate: (date){
                      formModel.plannedEndDate=date;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DropdownSerachWidget(
                    selectedId: formModel.userID,
                    items: formModel.userSelects,
                    dropdownLabel: "Sorumlu",
                    onChange: (val){
                      formModel.userID=val.id;
                    },
                  ),
                  Divider(color: Colors.black,),
                  SizedBox(
                    height: 5,
                  ),
                  DropdownSerachWidget(
                    selectedId: 2,
                    items: formModel.priority,
                    dropdownLabel: "Öncelik",
                    onChange: (val){
                      formModel.taskPriority=val.id;
                    },
                  ),
                  Divider(color: Colors.black,),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        //Activitiden Model Alınacak
                        try{
                          await model.createTask(formModel).then((value){
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

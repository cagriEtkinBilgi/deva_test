import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/data/view_models/task_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';
import 'package:deva_test/components/task_copmlate_status_date_widget.dart';
import 'package:deva_test/models/task_models/task_status_form_model.dart';

class TaskComplateFormPage extends StatelessWidget {

  int id;
  String title;
  TaskComplateFormPage({Map args}){
    if(args!=null){
      this.id=args["id"];
      this.title=args["title"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title - Görev Güncelle"),
      ),
      body: buildScrean(),
    );
  }

  Widget buildScrean(){
    return BaseView<TaskViewModel>(
      onModelReady: (model) {
        model.getTaskStatusForm();

      },
      builder: (context,model,widget){
        if(model.apiState==ApiStateEnum.LodingState)
          return ProgressWidget();
        else if(model.apiState==ApiStateEnum.LoadedState)
          return buildBody(context, model);
        else
          return CustomErrorWidget(model.onError);
      },
    );
  }

  Widget buildBody(BuildContext context,TaskViewModel model) {
    TaskStatusFormModel formModel=model.taskStatusFormModel;

    return Card(
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TaskCoplateStatusDate(
                init: 0,
                onChangeStatus: (TaskStatusFormModel model){
                  formModel=model;

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () async {
                    try{
                      formModel.id=id;
                      await model.setTaskStatus(formModel).then((value){
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
                  child: Text("Kaydet",
                    style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                ),
              ),
            )
          ],

        ),
      ),
    );
  }


}

import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/main_list_text.dart';
import 'package:deva_test/data/view_models/work_group_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/workgroups_models/workgroups_model.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class WorkGroupAction extends StatelessWidget {
  WorkGroupModel workModel;
  WorkGroupAction({this.workModel});
  @override
  Widget build(BuildContext context) {
    return buildBaseView(workModel,context);
  }
  Widget buildBaseView(workModel,BuildContext context) {
    return BaseView<WorkGroupViewModel>(
      onModelReady: (model){
        model.getWorkGroupActivitys(workModel.id);
      },
      builder: (context,model,child){
        if(model.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          print(workModel.authorizationStatus);
          return buildDetailCard(model,context);
        }
      },
    );
  }
  Widget buildDetailCard(WorkGroupViewModel model,BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: ListView.separated(
            itemCount: model.workGroupActions.length,
            itemBuilder: (context,i){
              var listItem=model.workGroupActions[i];
              return Container(
                child: ListTile(
                    onTap: (){
                      Navigator.pushNamed<dynamic>(context,'/ActivitiesDetailPage',arguments: {
                        "id":listItem.id,
                        "title":listItem.name
                      });
                    },
                    title: Text(listItem.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainListText(
                          text: listItem.workGroup,
                          lenght: 90,
                        ),
                      ],
                    )
                ),
              );
            },
            separatorBuilder: (context,i)=>Divider(),

          )
        ),
        Visibility(
          visible: (workModel.authorizationStatus==2),
          child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 25,bottom: 25),
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: (){
                    Navigator.of(context).pushNamed('/ActivitiesFormPage',arguments: {"workGroupId":workModel.id}).then((value){
                      if(value)
                        model.getWorkGroupActivitys(workModel.id);
                    });
                  },
                ),
              )
          ),
        )
      ],
    );
  }
}

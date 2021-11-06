import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/main_list_text.dart';
import 'package:deva_test/data/view_models/work_group_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/workgroups_models/workgroups_model.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/activity_color.dart';
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
          child: ListView.builder(
            itemCount: model.workGroupActions.length,
            itemBuilder: (context,i){
              var listItem=model.workGroupActions[i];
              return Container(
                decoration: BoxDecoration(
                  color: (i % 2 == 0)? Colors.white:Color.fromRGBO(211, 216, 237, 0.2),
                ),
                padding: EdgeInsets.only(top: 4,bottom: 10),
                child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              child: ListTile(
                                  onTap: (){
                                    Navigator.pushNamed<dynamic>(context,'/ActivitiesDetailPage',arguments: {"id":listItem.id,"title":listItem.name});
                                  },
                                  title: Text(listItem.name),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildListText(listItem.workGroup),
                                    ],
                                  )
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: 16,right: 16),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Durum",style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).accentColor
                                        ),),
                                        buildStatus(context,listItem.activityStatus),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                      Center(
                        child: Icon(Icons.arrow_forward_ios_outlined,color: Theme.of(context).primaryColor,),
                      )
                    ],
                  ),
              );
            },
          )
        ),

      ],
    );
  }
  Widget buildStatus(BuildContext context,int status) {
    return Container(
      decoration: BoxDecoration(
        color: ActicityColors.getActivityStatusColor(status),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 2,bottom: 2,left: 8,right: 8),
        child: Text(ActicityColors.getActivityStatusText(status),style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),),
      ),
    );
  }
  Text buildListText(String desc) {
    if(desc==null)
      return Text("");
    if(desc.length>50){
      return Text(desc.substring(0,50)+"...");
    }else
      return Text(desc);
  }

}

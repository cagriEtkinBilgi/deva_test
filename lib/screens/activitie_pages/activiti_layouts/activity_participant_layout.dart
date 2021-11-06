import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/components/user_components/user_avatar_widget.dart';
import 'package:deva_test/data/view_models/activity_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/activity_color.dart';
import 'package:flutter/material.dart';

class ActivityParticipantLayout extends StatelessWidget {
  int id;
  ActivityParticipantLayout({Key key,this.id}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-100,
      child: buildBaseView()
    );
  }

  BaseView<ActivityViewModel> buildBaseView() {
    return BaseView<ActivityViewModel>(
      onModelReady: (model){
        model.getActivityParticipant(id);
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

  Widget buildDetailCard(ActivityViewModel model,context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            Center(
              child: Text("Katılımcılar",style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            Expanded(
              child: Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: model.participants.length,
                    itemBuilder: (context,i){
                      var user=model.participants[i];
                      return InkWell(
                        onTap: (){
                          if(user.excuse!=null){
                            CustomDialog.instance.InformDialog(context, "Mazeret", user.excuse);
                          }
                        },
                        child: Card(
                          
                          child: Column(
                            children: [
                              Expanded(
                                child: UserAvatarWidget(
                                  url: user.imageURL,
                                ),
                              ),
                              Text("${user.name} ${user.surname}"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ActicityColors.getActivityParticipanStatusColor(user.activityParticipantStatus),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 2,bottom: 2,left: 8,right: 8),
                                    child: Center(
                                      child: Text(ActicityColors.getActivityParticipanStatusText(user.activityParticipantStatus),
                                        style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      );
                    }
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

}

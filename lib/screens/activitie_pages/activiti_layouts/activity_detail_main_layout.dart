import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/check_list_widget.dart';
import 'package:deva_test/components/custom_detail_card_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/data/view_models/activity_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/component_models/check_list_model.dart';
import 'package:deva_test/models/component_models/custom_card_detail_model.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ActivityDetailMainLayout extends StatelessWidget {
  int id;
  ActivityDetailMainLayout({this.id});
  @override
  Widget build(BuildContext context) {
    return buildScrean();
  }
  Widget buildScrean(){
    return BaseView<ActivityViewModel>(
      onModelReady: (model){
        model.getActivity(id);
      },
      builder: (context,model,child){
        if(model.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          return buildDetailCard(context,model);
        }
      },
    );
  }

  Widget buildDetailCard(BuildContext context,ActivityViewModel model) {
    var detail=model.activity;
    return Stack(
      children: [
        Container(
          child: CustomCardWidget(
            cards: [
              CustomCardDetailModel(
                  title: "Açıklama",
                  content: detail.desc,
                  cardIcon: Icons.content_paste
              ),
              CustomCardDetailModel(
                  title: "Çalışma Grubu",
                  content: detail.workGroup,
                  cardIcon: Icons.group
              ),
              CustomCardDetailModel(
                  title: "Kategori",
                  content: detail.activityTypeStr,
                  cardIcon: Icons.account_tree_outlined
              ),
              CustomCardDetailModel(
                  title: "Konumu",
                  content: detail.locationName??"",
                  cardIcon: Icons.map
              ),
              CustomCardDetailModel(
                  title: "Planlanan Başlangıç Tarihi",
                  content: (detail.plannedStartDateStr+" - "+detail.plannedStartTime),
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Planlanan Bitiş Tarihi",
                  content: (detail.plannedEndDateStr+" - "+detail.plannedEndTime),
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  isLink: true,
                  title: "Davet Linki",
                  content: detail.inviteLink,
                  cardIcon: Icons.wifi
              ),
              CustomCardDetailModel(
                  title: "Gerçekleşen Başlangıç Tarihi",
                  content:(detail.startDateStr!="")?(detail.startDateStr+" - "+detail.startTime):"",
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Gerçekleşen Bitiş Tarihi",
                  content:(detail.endDateStr!="")? (detail.endDateStr+" - "+detail.endTime):"",
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Üst Birim",
                  content: detail.isWithUpperUnitStr,
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Herkese Açık",
                  content: detail.isPublicStr,
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Özet",
                  content: detail.summary??"",
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Sonuç",
                  content: detail.returns??"",
                  cardIcon: Icons.date_range
              ),
            ],
          ),
        ),
        Visibility(
          visible: (detail.authorizationStatus==2),
          child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 25,bottom: 25),
                child: SpeedDial(
                  backgroundColor:  Theme.of(context).primaryColor,
                  animatedIcon: AnimatedIcons.menu_close,
                  children: [
                    SpeedDialChild(
                      child: Icon(Icons.people),
                      label: "Yoklama",
                      onTap: (){
                        addParticipants(context,model,id);
                      }
                    ),
                    SpeedDialChild(
                        child: Icon(Icons.person_rounded),
                        label: "Kişi Ekle",
                        onTap: (){
                          addInvadedUser(context,model,id);
                        }
                    ),
                    SpeedDialChild(
                        child: Icon(Icons.check_outlined),
                        label: "Faaliyet Tamamla",
                        onTap: (){
                          Navigator.pushNamed<dynamic>(context,'/ActivitiesCompleteForm',arguments: {"id":id}).then((value){
                            if(value==true){
                              model.getActivity(id);
                            }
                          });
                        }
                    ),

                  ],
                )
              )
          ),
        )
      ],
    );
  }
  Future<bool> addParticipants(BuildContext context,ActivityViewModel model,int id) async {
    return await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Yoklama Listesi"),
            content: FutureBuilder<List<CheckListModel>>(
                future: model.getParticipantsUser(id),
                builder: (context,dataModel){
                  if (!dataModel.hasData){
                    return ProgressWidget();
                  }else{
                    return CheckListWidget(
                      checks: dataModel.data,
                      onSaveAsyc: (List<CheckListModel> checks) async {
                        try{
                          return await model.updateParticipantsUser(checks, id);
                        }catch(e){
                          throw e;
                        }

                      },
                    );
                  }
                }
            ),
          );
        }

    );
  }

  Future<bool> addInvadedUser(BuildContext context,ActivityViewModel model,int id) async {
    return await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Kişi Ekle"),
            content: FutureBuilder<List<CheckListModel>>(
                future: model.getInvadedUser(id),
                builder: (context,dataModel){
                  if (!dataModel.hasData){
                    return ProgressWidget();
                  }else{
                    return CheckListWidget(
                      checks: dataModel.data,
                      onSaveAsyc: (List<CheckListModel> checks) async {
                        try{
                          return await model.addUserToActivity(checks, id);
                        }catch(e){
                          throw e;
                        }

                      },
                    );
                  }
                }
            ),
          );
        }

    );
  }

}

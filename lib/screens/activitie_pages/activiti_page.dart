import 'package:deva_test/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/data_search_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/components/navigation_bar.dart';
import 'package:deva_test/components/navigation_drawer.dart';
import 'package:deva_test/components/note_add_dialog.dart';
import 'package:deva_test/data/view_models/activity_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/activity_models/activity_list_model.dart';
import 'package:deva_test/models/component_models/note_add_model.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/activity_color.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ActivitiePage extends StatelessWidget {
  int typeID;
  int selectedFilter;
  ActivitiePage({Map args,this.selectedFilter=-1}){
    if(args["typeID"]!=null)
      typeID=args["typeID"];
  }
  var _scroolController= ScrollController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/MainPage');
        return false;
      },
      child: BaseView<ActivityViewModel>(
        onModelReady: (model){
          model.getActivitys(typeID,selectedFilter);
        },
        builder:(context,model,child)=> Scaffold(
          appBar: AppBar(
            title: _buildTitle(typeID),
            elevation: AppTools.getAppBarElevation(),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  tooltip: "Ara",
                  onPressed: (){
                    showSearch(
                      context: context,
                      delegate: DataSearch(pageID:2 ),

                    );
                  }

              ),
              IconButton(
                  icon: Icon(Icons.format_list_bulleted),
                  tooltip: "Filtreler",
                  onPressed: () async {
                    var result= await Navigator.pushNamed<dynamic>(context,'/ActivityFilter',arguments: {"selectedID":selectedFilter});
                    if(result!=null){
                      selectedFilter=result;
                      await model.getActivitys(typeID,selectedFilter);
                    }
                  }

              ),
            ],
            flexibleSpace: FlexibleSpaceBackground(),
          ),
          drawer: NavigationDrawer(),
          bottomNavigationBar: NavigationBar(selectedIndex: 0,),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add
            ),
            onPressed: (){
              //CreateActivity
              Navigator.pushNamed<dynamic>(context,'/CreateActivity');
            },
          ),
          body: buildScreen(context,model),
        ),
      ),
    );
  }

  Text _buildTitle(int type){
    if(type==2)
      return Text("Açık Faliyetler");
    if(type==1)
      return Text("Benim Faliyetlerim");
    else
      return Text("Faliyetler");
  }

  Widget buildScreen(context, ActivityViewModel model){
    if(model.apiState==ApiStateEnum.LoadedState){
      return buildListView(model);
    }else if(model.apiState==ApiStateEnum.ErorState){
      return CustomErrorWidget(model.onError);
    }else {
      return ProgressWidget();
    }
  }

  Widget buildListView(ActivityViewModel model) {
    return NotificationListener<ScrollEndNotification>(
      onNotification:(t){
        if (t.metrics.pixels >0 && t.metrics.atEdge) {
          if(!model.isPageLoding){
            model.getActivityNextPage(typeID,selectedFilter);
          }
        }
        return null;
      },
      child: RefreshIndicator(
        onRefresh: () async{
          return await model.getActivitys(typeID,selectedFilter);
        },
        child: Stack(
          children: [
            ListView.builder(
                controller: _scroolController,
                itemCount: model.activitys.length,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context,i){
                  var listItem=model.activitys[i];
                  return Container(
                    decoration: BoxDecoration(
                      color: (i % 2 == 0)? Colors.white:Color.fromRGBO(211, 216, 237, 0.2),
                    ),
                    padding: EdgeInsets.only(top: 4,bottom: 10),
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.20,
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
                                            buildListText(listItem.desc),
                                            SizedBox(height: 8,),
                                            Row(
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(

                                                  child:Text(listItem.workGroup,style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context).accentColor
                                                  ),),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: buildStatus(context,listItem.activityStatus),
                                                )

                                              ],
                                            )
                                          ],
                                        ),
                                      leading: _buildCardLeading(listItem),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Icon(Icons.arrow_forward_ios_outlined,color: Theme.of(context).primaryColor,),
                            )
                          ],
                        ),
                      secondaryActions: secondaryActions(
                          context,
                          model,
                          listItem),
                    ),
                  );
                },

            ),
            buildPagePrgres(model.isPageLoding),
          ],
        ),
      ),
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
        child: Center(
          child: Text(ActicityColors.getActivityStatusText(status),style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),),
        ),
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

  Widget _buildCardLeading(ActivityListModel model){
    var dateStrs=model.plannedStartDate.split('-');
    var dayStr=dateStrs[2].split('T');
    return Column(
      children: [
          Text(dayStr[0],style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),),
          Text(dateStrs[1],style:TextStyle(fontSize: 12),),
          Text(dateStrs[0],style:TextStyle(fontSize: 12),),
      ],
    );
  }

  List<Widget> secondaryActions(BuildContext context,ActivityViewModel model,ActivityListModel listModel) {
    if(listModel.authorizationStatus==2){
      return [
        IconSlideAction(
          caption: 'Güncelle',
          color: Colors.lightBlueAccent,
          icon: Icons.more,
          onTap: () {
            Navigator.of(context).pushNamed('/ActivitiesFormPage',arguments: {
              "workGroupId":listModel.workGroupID,
              "id":listModel.id,
              "title":listModel.name,
            }).then((value){
              if(value==true){
                model.getActivitys(typeID,selectedFilter);
              }
            });
          },
        ),
        IconSlideAction(
          caption: 'Tamamla',
          color: Colors.lightBlue,
          icon: Icons.check_outlined,
          onTap: () {
            Navigator.pushNamed<dynamic>(context,'/ActivitiesCompleteForm',arguments: {"id":listModel.id});
          },
        ),
        IconSlideAction(
          caption: 'Mazeret Ekle',
          color: Colors.blue,
          icon: Icons.add_road_rounded,
          onTap: () {
            addExcuseDialogForm(context,model,listModel.id).then((value) =>{

            });

          },
        ),
        IconSlideAction(
          caption: 'Sil',
          color: Colors.indigo,
          icon: Icons.delete,
          onTap: () async {
            await CustomDialog.instance.confirmeMessage(
              context,
              title: "Silme Onayı",
              cont: "${listModel.name} - Faliyetini Silmek İstediğiniden Emin Misiniz?"
            ).then((value) async {
              if(value){
                 await model.deleteActivity(listModel.id).then((value) =>{
                   if(value){
                     model.getActivitys(typeID,selectedFilter)
                   }
                 });

              }
            });
          },
        ),
      ];
    }else{
      return [
        IconSlideAction(
          caption: 'Mazeret Ekle',
          color: Colors.blue,
          icon: Icons.add_road_rounded,
          onTap: () {
             addExcuseDialogForm(context,model,listModel.id).then((value) =>{

             });
          },
        ),
      ];
    }

  }

  Container buildPagePrgres(bool isLoading) {
    return (!isLoading)?Container():Container(
      child: ProgressWidget(),
    );
  }

  Future<bool> addExcuseDialogForm(BuildContext context,ActivityViewModel model,int activityID)async {
    return await showDialog(
        context:context,
        builder: (context){
          return AlertDialog(
            content: NoteAddDialog(
              title: "Mazeret Ekle",
              label: "Mazeret",
              onNoteSaveAsyc: (NoteAddDialogModel dialogModel) async {
                dialogModel.activityID=activityID;

                return await model.addActivityExcuse(dialogModel);
              },
            ),
          );
        }
    );
  }

}

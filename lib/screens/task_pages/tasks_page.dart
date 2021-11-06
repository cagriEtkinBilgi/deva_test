import 'package:deva_test/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/data_search_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/components/navigation_bar.dart';
import 'package:deva_test/components/navigation_drawer.dart';
import 'package:deva_test/data/view_models/task_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/task_models/task_list_model.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/activity_color.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class TasksPage extends StatelessWidget {
  var _scroolController= ScrollController();
  int selectedFilter=-1;

  TasksPage({this.selectedFilter=-1});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacementNamed('/MainPage');
          return false;
        },
      child: BaseView<TaskViewModel>(
        onModelReady: (model){
          model.getTasks(selectedFilter);
        },
        builder:(context,model,widget)=> Scaffold(
          appBar: AppBar(
            title: Text("Aksiyonlar"),
            elevation: AppTools.getAppBarElevation(),
            flexibleSpace: FlexibleSpaceBackground(),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  tooltip: "Ara",
                  onPressed: (){
                    showSearch(
                      context: context,
                      delegate: DataSearch(pageID:3 ),
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
                      model.getTasks(selectedFilter);
                    }
                  }

              ),
              //IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
            ],
          ),
          floatingActionButton: Visibility(
            visible: true,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                Navigator.of(context).pushNamed('/TaskFormPage').then((value){
                try{
                  if(value!=null){
                      model.getTasks(selectedFilter);
                  }else{
                    CustomDialog.instance.exceptionMessage(context);
                  }
                  }catch(e){

                  }

                });
              },
            ),
          ),
          drawer: NavigationDrawer(),
          bottomNavigationBar: NavigationBar(selectedIndex: 0,),
          body: Container(child:Center(child: buildScreen(context,model),) ,),
        ),
      ),
    );
  }
  Widget buildScreen(context, TaskViewModel model){
    if(model.apiState==ApiStateEnum.LoadedState){
      return buildListView(model);
    }else if(model.apiState==ApiStateEnum.ErorState){
      return CustomErrorWidget(model.onError);
    }else {
      return ProgressWidget();
    }
  }
  Widget buildListView(TaskViewModel model) {
    return NotificationListener<ScrollEndNotification>(
      onNotification:(t){
        if (t.metrics.pixels >0 && t.metrics.atEdge) {
          if(!model.isPageLoding){
            model.getTasksNextPage(selectedFilter);
          }
        }
        return null;
      },
      child: RefreshIndicator(
        onRefresh: () async{
          return await model.getTasks(selectedFilter);
        },
        child: Stack(
          children: [
            ListView.builder(
                controller: _scroolController,
                itemCount: model.tasks.length,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context,i){
                  var listItem=model.tasks[i];
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
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
                                        Navigator.pushNamed<dynamic>(context,'/TaskDetailPage',arguments: {
                                          "id":listItem.id,
                                          "title":listItem.name
                                        });
                                      },
                                      title: Text(listItem.name),
                                      leading: _buildCardLeading(listItem),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(listItem.assignerNameSurname),
                                          Container(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("Durum",style: TextStyle(
                                                        fontSize: 16,
                                                        color: Theme.of(context).accentColor
                                                    ),),
                                                    buildStatus(context,listItem.taskStatus),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("Öncelik",style: TextStyle(
                                                        fontSize: 16,
                                                        color: Theme.of(context).accentColor
                                                    ),),
                                                    buildPriority(context,listItem.taskPriority),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                /*Padding(
                                  padding:  EdgeInsets.only(left: 16,right: 16,),
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
                                            buildStatus(context,listItem.taskStatus),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Öncelik",style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context).accentColor
                                            ),),
                                            buildPriority(context,listItem.taskPriority),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )*/
                              ],
                            ),
                          ),
                          Center(
                            child: Icon(Icons.arrow_forward_ios_outlined,color: Theme.of(context).primaryColor,),
                          )
                        ],
                      ),
                    ),
                    secondaryActions: secondaryActions(context,listItem,model),
                  );
                },
            ),
            buildPagePrgres(model.isPageLoding),
          ],
        ),
      ),
    );
  }
  List<Widget> secondaryActions(BuildContext context, TaskListModel listItem, TaskViewModel model,) {
    if(listItem.authorizationStatus==2){
      return [
        Visibility(
          child: IconSlideAction(
            caption: 'Güncelle',
            color: Colors.blue,
            icon: Icons.more,
            onTap: () {
              Navigator.of(context).pushNamed('/TaskFormPage',arguments: {"id":listItem.id,"title":listItem.name}).then((value){
                try{
                  if(value){
                    model.getTasks(selectedFilter);
                  }else{
                    CustomDialog.instance.exceptionMessage(context);
                  }
                }catch(e){

                }
              });
              },
          ),
          visible: true,
        ),
        IconSlideAction(
          caption: 'Sil',
          color: Colors.indigo,
          icon: Icons.delete,
          onTap: () {
            CustomDialog.instance.confirmeMessage(
              context,
              title: "Silme Onayı",
              cont: "${listItem.name} - Silmek İstediğinizden Emin Misiniz?",
              confirmBtnTxt: "Evet",
              unConfirmeBtnTxt: "Hayır",
            ).then((value) {
              if(value){

                model.deleteTask(listItem.id);
              }
            });
          },
        ),
      ];
    }else{
      return [ ];
    }
  }

  Container buildPagePrgres(bool isLoading) {
    return (!isLoading)?Container():Container(
      child: ProgressWidget(),
    );
  }

  Widget _buildCardLeading(TaskListModel model){
    var dateStrs=model.plannedStartDate.split('.');
    return Column(
      children: [
        Text(dateStrs[0],style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),),
        Text(dateStrs[1],style:TextStyle(fontSize: 12),),
        Text(dateStrs[2],style:TextStyle(fontSize: 12),),
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
  Widget buildPriority(BuildContext context,int status) {
    return Container(
      decoration: BoxDecoration(
        color: ActicityColors.getActivityPriorityColor(status),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 2,bottom: 2,left: 8,right: 8),
        child: Text(ActicityColors.getActivityPriorityText(status),style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),),
      ),
    );
  }
}

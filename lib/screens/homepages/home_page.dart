import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/dashbord_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/components/navigation_bar.dart';
import 'package:deva_test/components/navigation_drawer.dart';
import 'package:deva_test/components/simple_card_min_widget.dart';
import 'package:deva_test/components/simple_card_widget.dart';
import 'package:deva_test/data/view_models/dashboard_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return CustomDialog.instance.confirmeMessage(
          _scaffoldKey.currentContext,
          confirmBtnTxt: "Evet",
          unConfirmeBtnTxt: "Vazgeç",
          title: "Uyarı",
          cont: "Çıkmak İstediğinizden Emin Misiniz?"
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Deva Portal"),
          elevation: AppTools.getAppBarElevation(),
          actions: [
            IconButton(
                icon: Icon(Icons.group_add),
                tooltip: "Profilim",
                onPressed: (){
                  Navigator.pushNamed(context, "/AddNewRelation");
                }
            ),
            //IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
          ],
        ),
        body: Center(
          child: buildScreen(),
        ),
        drawer: NavigationDrawer(),

        bottomNavigationBar: NavigationBar(selectedIndex: 0,),
      ),
    );
  }
  Widget buildScreen(){
  return BaseView<DashboardViewModel>(
      onModelReady: (model) async {
        model.getDashboard();
        await Firebase.initializeApp();
        FirebaseAuth.instance.signInAnonymously().then((value){
          print(value.user.uid.toString());
        });

        await FirebaseMessaging.instance.subscribeToTopic("all");
        /*FirebaseMessaging.onBackgroundMessage((message){
            if(message!=null)
              print("On Baground Mesage ${message}");
        });*/
        FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
          if(message!=null)
            print('message recived${message}');
        });
      },
      builder: (context, model, child) {
        if (model.apiState == ApiStateEnum.LodingState) {
          return ProgressWidget();
        } else if (model.apiState == ApiStateEnum.ErorState) {
          return CustomErrorWidget(model.onError);
        } else {
          return buildDashboardList(context, model);
        }
      }
  );

}

  Widget buildDashboardList(BuildContext context, model) {
    return RefreshIndicator(
      onRefresh: () async {
        return await model.getDashboard();
      },
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          SimpleCardWidget(
            title: "Çalışma Grubu",
            decorationColor: Theme.of(context).primaryColor,
            icon: Icons.message,
            textColor: Colors.white,
            subTitle: "Bulunduğum Çalışma Grupları",
            count: model.dashboard.workGroupsCount,
            onClick: () {
              Navigator.of(context).pushReplacementNamed('/WorkGroups');
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SimpleCardMinWidget(
                  title: "Faaliyetlerim",
                  decorationColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  countColor: Colors.white,
                  count: model.dashboard.activitiesCount,
                  onClick: () {
                    Navigator.of(context).pushReplacementNamed('/ActivitiesPage',arguments: {"typeID":0});
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: SimpleCardMinWidget(
                  title: "Açık Faliyetler",
                  decorationColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  countColor: Colors.white,
                  count: model.dashboard.publicActivitiesCount,
                  onClick: () {
                    Navigator.of(context).pushReplacementNamed('/ActivitiesPage',arguments: {"typeID":1});
                  },
                ),
              ),

            ],
          ),
          SizedBox(
            height: 10,
          ),
          SimpleCardWidget(
            title: "Aksiyonlar",
            decorationColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            icon: Icons.backup_table,
            subTitle: "Sorumlu Olduğum Aksiyonlar",
            count: model.dashboard.tasksCount,
            onClick: () {
              Navigator.of(context).pushReplacementNamed('/TasksPage');
            },
          ),
          SizedBox(
            height: 10,
          ),
          SimpleCardWidget(
            title: "Takvimim",
            decorationColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            icon: Icons.calendar_today_outlined,
            subTitle: "Görev Ve Faaliyet Takvimi",
            count: 0,
            onClick: () {
              Navigator.of(context).pushReplacementNamed('/CalendarMainPage');
            },
          ),
        ],
      ),
    );
  }


}




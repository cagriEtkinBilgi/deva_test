import 'package:cached_network_image/cached_network_image.dart';
import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/models/security/sesion_model.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:deva_test/tools/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'circular_avatar_image.dart';

class NavigationDrawer extends StatelessWidget {
  SecurityViewModel model;
  NavigationDrawer();
  double tileHeigt =50;
  @override
  Widget build(BuildContext context) {
    model=Provider.of<SecurityViewModel>(context);
    return Drawer(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          children: [
            getDrawMenuTitle(),
            Expanded(
              flex: 12,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height:tileHeigt,
                      child: ListTile(
                        title: Text("Ana Sayfa",style:textStyle,),
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed('/MainPage');
                        },
                        leading: Icon(Icons.home_outlined,color: Colors.grey,),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      ),
                    ),
                    Divider(color: Colors.black,),
                    Container(
                      height: tileHeigt,
                      child: ListTile(
                        title: Text("Çalışma Grupları",style:textStyle,),
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed('/WorkGroups');
                        },
                        leading: Icon(Icons.message,color: Colors.grey,),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      ),
                    ),
                    Divider(color: Colors.grey,),
                    Container(
                      height: tileHeigt,
                      child: ListTile(
                        title: Text("Faaliyetler",style:textStyle,),
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed('/ActivitiesPage',arguments: {"typeID":0});
                        },
                        leading: Icon(Icons.speaker_group_outlined,color: Colors.grey,),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      ),
                    ),
                    Divider(color: Colors.grey,),
                    Container(
                      height: tileHeigt,
                      child: ListTile(
                        title: Text("Aksiyonlar",style:textStyle,),
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed('/TasksPage');
                        },
                        leading: Icon(Icons.edit,color: Colors.grey,),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      ),
                    ),
                    Divider(color: Colors.grey,),
                    Container(
                      height: tileHeigt,
                      child: ListTile(
                        title: Text("Takvim",style:textStyle,),
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed('/CalendarMainPage');
                        },
                        leading: Icon(Icons.calendar_today_outlined,color: Colors.grey,),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child:Center(
                    child: GestureDetector(
                      excludeFromSemantics: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.power_settings_new_sharp,color: Colors.white,),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Çıkış",style: textStyle,)
                        ],
                      ),
                      onTap: (){
                        model.Logout().then((value){
                          if(value){
                            Navigator.of(context).pushReplacementNamed('/Login');
                          }else{
                            print("Hata");
                          }
                        });
                      },
                    )
                )
            )
          ],
        ),
      ),
    );
  }
  Widget getDrawMenuTitle(){
    return FutureBuilder(
      future:model.getCurrentSesion(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          SesionModel model=snapshot.data;
          return UserAccountsDrawerHeader(
            accountName: Text(model.name+" "+model.surname),
            accountEmail:  Text(model.email),
            currentAccountPicture: CircleAvatar(
              child: CircularAvatarComponent(Uri: model.imageURL),
            ),
          );
        }else{
          return Container(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
      },
    );
  }

}



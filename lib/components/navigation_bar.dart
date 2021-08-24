import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  int selectedIndex;
  NavigationBar({int selectedIndex}){
    if(selectedIndex==null){
      this.selectedIndex=0;
    }else{
      this.selectedIndex=selectedIndex;
    }
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              label:"Ana Sayfa" ,
              icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              label:"Çalışma Grupları",
              icon: Icon(Icons.work)
          ),
          BottomNavigationBarItem(
              label:"Profil" ,
              icon: Icon(Icons.person_rounded)
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue.shade900,
        onTap: (int index){
          if(index==0){
            Navigator.of(context).pushReplacementNamed('/MainPage');
          }else if(index==1){
            Navigator.of(context).pushReplacementNamed('/WorkGroups');
          }else if(index==2){
            Navigator.pushNamed(context, "/ProfilePage");
          }
        },
      );
    }


}

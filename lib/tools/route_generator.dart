
import 'package:deva_test/screens/activitie_pages/activiti_page.dart';
import 'package:deva_test/screens/activitie_pages/activity_complete_form.dart';
import 'package:deva_test/screens/activitie_pages/activity_detail_page.dart';
import 'package:deva_test/screens/activitie_pages/activity_form_page.dart';
import 'package:deva_test/screens/calendar_pages/calendar_main_page.dart';
import 'package:deva_test/screens/homepages/home_page.dart';
import 'package:deva_test/screens/notes_pages/activitie_notes_page.dart';
import 'package:deva_test/screens/notes_pages/task_notes_page.dart';
import 'package:deva_test/screens/public_relations/add_new_relation_page.dart';
import 'package:deva_test/screens/security/login_page.dart';
import 'package:deva_test/screens/security/profile_pages.dart';
import 'package:deva_test/screens/security/splash_screen.dart';
import 'package:deva_test/screens/security/update_user_profile_form.dart';
import 'package:deva_test/screens/task_pages/task_detail_page.dart';
import 'package:deva_test/screens/task_pages/task_form_page.dart';
import 'package:deva_test/screens/task_pages/tasks_page.dart';
import 'package:deva_test/screens/task_pages/task_complate_form_page.dart';
import 'package:deva_test/screens/workgroup_pages/workgroup_detail_page.dart';
import 'package:deva_test/screens/workgroup_pages/workgroup_page.dart';
import 'package:flutter/material.dart';


class RouteGenerator{
  static Route<dynamic> routeGenerator(RouteSettings settings){
    if(settings!=null){
      switch(settings.name){
        case '/':
          return MaterialPageRoute(builder: (_)=>SplashScreen());
          break;
        case '/Login':
          return MaterialPageRoute(builder: (_)=>LoginPage());
          break;
        case '/MainPage':
          return MaterialPageRoute(builder: (_)=>HomePage());
          break;
        case '/WorkGroups':
          return MaterialPageRoute(builder: (_)=>WorkGroupPage());
          break;
        case '/WorkGroupDetail':
          final args=settings.arguments;
          return MaterialPageRoute(builder: (_)=>WorkGruopDetailPage(workModel: args,));
          break;
        case '/ActivitiesPage':
          final args=settings.arguments;//Parametre Düzenlenecek
          return MaterialPageRoute(builder: (_)=>ActivitiePage(args: args));
          break;
        case '/ActivitiesDetailPage':
          final args=settings.arguments;//Parametre Düzenlenecek
          return MaterialPageRoute(builder: (_)=>ActivityDetailPage(args: args,));
          break;
        case '/ActivitiesFormPage':
          final args=settings.arguments;//Parametre Model
          return MaterialPageRoute(builder: (_)=>ActivityFormPage(args: args,));
          break;
        case '/ActivitiesCompleteForm':
          final args=settings.arguments;//Parametre Model
          return MaterialPageRoute(builder: (_)=>ActivityCompleteForm(args: args,));
          break;
        case '/TasksPage':
          return MaterialPageRoute(builder: (_)=>TasksPage());
          break;
        case '/TaskDetailPage':
          final args=settings.arguments;//Parametre Map
          return MaterialPageRoute(builder: (_)=>TaskDetailPage(args: args,));
          break;
        case '/TaskFormPage':
          final args=settings.arguments;//Parametre Map
          return MaterialPageRoute(builder: (_)=>TaskFormPage(args: args,));
          break;
        case '/TaskComplateFormPage':
          final args=settings.arguments;//Parametre Map
          return MaterialPageRoute(builder: (_)=>TaskComplateFormPage(args:args));
          break;
        case '/ActivitieNotePage':
          return MaterialPageRoute(builder: (_)=>ActivitieNotePage());
          break;
        case '/TaskNotePage':
          return MaterialPageRoute(builder: (_)=>TaskNotesPage());
          break;
        case '/ProfilePage':
          final args=settings.arguments;//Parametre Map
          return MaterialPageRoute(builder: (_)=>ProfilePage(args: args,));
          break;
        case '/ProfileUpdatePage':
          final args=settings.arguments;//Parametre Map
          return MaterialPageRoute(builder: (_)=>UpdateUserProfileForm(args: args,));
          break;
        case '/CalendarMainPage':
          return MaterialPageRoute(builder: (_)=>CalendarMainPage());
          break;
        case '/AddNewRelation':
          return MaterialPageRoute(builder: (_)=>AddNewRelationPage());
          break;
        default:
          return _errorRoute();
      }
    }else{
      return _errorRoute();
    }

  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text("Hata"),
        ),
        body: Center(
          child: Text("Hata"),
        ),
      );
    });

  }
}
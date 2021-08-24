import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHandler{

  static NotificationHandler _instance;
  static NotificationHandler get instance{
    if(_instance==null)_instance=NotificationHandler._init();
    return _instance;
  }
 FirebaseMessaging fcm= FirebaseMessaging.instance;
  NotificationHandler._init();

  initialNotification()async{
    fcm.getInitialMessage().then((mesage){
      print("get $mesage");
    });
  }

}
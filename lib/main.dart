import 'package:deva_test/tools/locator.dart';
import 'package:deva_test/tools/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'data/uow_providers.dart';

//Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
 // await Firebase.initializeApp();

//  print("Handling a background message: ${message.messageId}");
//}

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);//push notification ayarları şuan çalışmıyor
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: UowProviders.getProviders(context),
      child: MaterialApp(
        title: 'Deva',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('tr', 'TR'),
          const Locale('en', 'US'),
        ],
        locale: Locale('tr'),
        theme: ThemeData(
          primaryColor: Colors.lightBlue.shade800,
          accentColor: Colors.grey.shade600,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: LoginPage(),
        onGenerateRoute: RouteGenerator.routeGenerator,
      ),
    );
  }


}

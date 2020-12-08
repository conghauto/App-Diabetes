import 'package:diabetesapp/routes.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/screens/info_personal/info_person_sreeen.dart';
import 'package:diabetesapp/screens/plan/plan_screen.dart';
import 'package:diabetesapp/screens/sign_in/sign_in_screen.dart';
import 'package:diabetesapp/screens/splash/splash_screen.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:diabetesapp/theme.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();



  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userID = prefs.getString('userID');
  if (userID!=null){
    await UserCurrent().init();
  }
  print(userID);


  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  await Hive.init(appDocumentDirectory.path);
  await Hive.openBox<int>('steps');
  initializeDateFormatting('vi_VN', null)
      .then((_) => runApp(MyApp(userID: userID)));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({
    Key key,
    this.userID,
  }) : super(key: key);
  final String userID;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Roboto'),
//      initialRoute: SplashScreen.routeName,
      initialRoute: (userID!=null&&UserCurrent.emailRelative!=null)? HomeScreen.routeName:SplashScreen.routeName,
//      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}

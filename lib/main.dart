
import 'package:diabetesapp/components/sign_in_google.dart';
import 'package:diabetesapp/routes.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/screens/sign_in/sign_in_screen.dart';
import 'package:diabetesapp/screens/splash/splash_screen.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:diabetesapp/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:io' show Platform;

import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final FirebaseApp app = await Firebase.initializeApp(
  //   name: 'db2',
  //   options: Platform.isIOS || Platform.isMacOS
  //       ? FirebaseOptions(
  //     appId: '1:297855924061:ios:c6de2b69b03a5be8',
  //     apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
  //     projectId: 'flutter-firebase-plugins',
  //     messagingSenderId: '297855924061',
  //     databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
  //   )
  //       : FirebaseOptions(
  //     appId: '1:673349133163:android:794aa8c407a8e5d650a22e',
  //     apiKey: 'AIzaSyAUNe1tc0dFpJdkHQJ_ROOtDKe6mIX0A84',
  //     messagingSenderId: '673349133163',
  //     projectId: 'diabetes-7aca8',
  //     databaseURL: 'https://diabetes-7aca8.firebaseio.com',
  //   ),
  // );
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  await Hive.init(appDocumentDirectory.path);
  await Hive.openBox<int>('steps');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: HomeScreen.routeName,
      routes: routes,
    );
  }
}
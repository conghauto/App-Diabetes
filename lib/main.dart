
import 'package:diabetesapp/components/sign_in_google.dart';
import 'package:diabetesapp/routes.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/screens/plan/plan_screen.dart';
import 'package:diabetesapp/screens/sign_in/sign_in_screen.dart';
import 'package:diabetesapp/screens/splash/splash_screen.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:diabetesapp/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
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
  initializeDateFormatting().then((_) => runApp(MyApp()));
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

//import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//
//void main() => runApp(new MyApp());
//
//class CustomPicker extends CommonPickerModel {
//  String digits(int value, int length) {
//    return '$value'.padLeft(length, "0");
//  }
//
//  CustomPicker({DateTime currentTime, LocaleType locale}) : super(locale: locale) {
//    this.currentTime = currentTime ?? DateTime.now();
//    this.setLeftIndex(this.currentTime.hour);
//    this.setMiddleIndex(this.currentTime.minute);
//    this.setRightIndex(this.currentTime.second);
//  }
//
//  @override
//  String leftStringAtIndex(int index) {
//    if (index >= 0 && index < 24) {
//      return this.digits(index, 2);
//    } else {
//      return null;
//    }
//  }
//
//  @override
//  String middleStringAtIndex(int index) {
//    if (index >= 0 && index < 60) {
//      return this.digits(index, 2);
//    } else {
//      return null;
//    }
//  }
//
//  @override
//  String rightStringAtIndex(int index) {
//    if (index >= 0 && index < 60) {
//      return this.digits(index, 2);
//    } else {
//      return null;
//    }
//  }
//
//  @override
//  String leftDivider() {
//    return "|";
//  }
//
//  @override
//  String rightDivider() {
//    return "|";
//  }
//
//  @override
//  List<int> layoutProportions() {
//    return [1, 2, 1];
//  }
//
//  @override
//  DateTime finalTime() {
//    return currentTime.isUtc
//        ? DateTime.utc(currentTime.year, currentTime.month, currentTime.day,
//        this.currentLeftIndex(), this.currentMiddleIndex(), this.currentRightIndex())
//        : DateTime(currentTime.year, currentTime.month, currentTime.day, this.currentLeftIndex(),
//        this.currentMiddleIndex(), this.currentRightIndex());
//  }
//}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Flutter Demo',
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: new HomePage(),
//    );
//  }
//}
//
//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Datetime Picker'),
//      ),
//      body: Center(
//        child: Column(
//          children: <Widget>[
//            FlatButton(
//                onPressed: () {
//                  DatePicker.showDateTimePicker(context, showTitleActions: true, onChanged: (date) {
//                    print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
//                  }, onConfirm: (date) {
//                    print('confirm $date');
//                  }, currentTime: DateTime(2008, 12, 31, 23, 12, 34));
//                },
//                child: Text(
//                  'show date time picker (English-America)',
//                  style: TextStyle(color: Colors.blue),
//                )),
//            FlatButton(
//                onPressed: () {
//                  DatePicker.showDateTimePicker(context, showTitleActions: true, onChanged: (date) {
//                    print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
//                  }, onConfirm: (date) {
//                    print('confirm $date');
//                  }, currentTime: DateTime.now(), locale: LocaleType.vi);
//                },
//                child: Text(
//                  'show date time picker in UTC (German)',
//                  style: TextStyle(color: Colors.blue),
//                )),
//          ],
//        ),
//      ),
//    );
//  }
//}
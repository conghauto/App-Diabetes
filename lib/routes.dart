
import 'package:diabetesapp/components/sign_in_google.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/food_recipe.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/sport_detail.dart';
import 'package:diabetesapp/screens/chart/pdf_viewer_screen.dart';
import 'package:diabetesapp/screens/chart/report_screen.dart';
import 'package:diabetesapp/screens/forgot_password/forgot_password.dart';
import 'package:diabetesapp/screens/glucose/add_log_screen.dart';
import 'package:diabetesapp/screens/glucose/log_screens/update_blood_glucoso.dart';
import 'package:diabetesapp/screens/glucose/log_screens/update_carbs.dart';
import 'package:diabetesapp/screens/glucose/log_screens/update_exercise.dart';
import 'package:diabetesapp/screens/glucose/log_screens/update_medicine.dart';
import 'package:diabetesapp/screens/glucose/log_screens/update_weight.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/screens/info_personal/info_person_sreeen.dart';
import 'package:diabetesapp/screens/more/components/setting.dart';
import 'package:diabetesapp/screens/more/components/update_infor_screen.dart';
import 'package:diabetesapp/screens/more/components/update_password_screen.dart';
import 'package:diabetesapp/screens/more/components/update_personal_infor.dart';
import 'package:diabetesapp/screens/plan/components/add_event.dart';
import 'package:diabetesapp/screens/more/more_screen.dart';
import 'package:diabetesapp/screens/plan/plan_screen.dart';
import 'package:diabetesapp/screens/sign_in/sign_in_screen.dart';
import 'package:diabetesapp/screens/sign_up/sign_up_screen.dart';
import 'package:diabetesapp/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes= {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ForgetPassword.routeName: (context) => ForgetPassword(),
  SignInGoogle.routeName: (context) => SignInGoogle(),
  AddEventScreen.routeName: (context) => AddEventScreen(),
  PlanScreen.routeName: (context) => PlanScreen(),
  AddLogSceen.routeName: (context) => AddLogSceen(),
  MoreScreen.routeName: (context) => MoreScreen(),
  EditProfilePage.routeName: (context) => EditProfilePage(),
  InfoPersonScreen.routeName: (context) => InfoPersonScreen(),
  ReportScreen.routeName: (context) => ReportScreen(),
  UpdateBloodGlucoso.routeName: (context) => UpdateBloodGlucoso(),
  UpdateMedicine.routeName: (context) => UpdateMedicine(),
  UpdateWeight.routeName: (context) => UpdateWeight(),
  UpdateCarbs.routeName: (context) => UpdateCarbs(),
  UpdateExercise.routeName: (context) => UpdateExercise(),
  RecipeFood.routeName: (context) => RecipeFood(),
  SportDetail.routeName: (context) => SportDetail(),
  EditPersonalInfo.routeName: (context) => EditPersonalInfo(),
  UpdatePassword.routeName: (context) => UpdatePassword(),
  SettingScreen.routeName: (context) => SettingScreen(),
};
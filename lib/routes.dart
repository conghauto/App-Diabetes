import 'package:diabetesapp/components/sign_in_google.dart';
import 'package:diabetesapp/screens/forgot_password/forgot_password.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/screens/more/components/update_infor_screen.dart';
import 'package:diabetesapp/screens/plan/components/add_event.dart';
import 'package:diabetesapp/screens/plan/components/view_event.dart';
import 'package:diabetesapp/screens/more/components/daily_steps_page.dart';
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
  DailyStepsPage.routeName: (context) => DailyStepsPage(),
  MoreScreen.routeName: (context) => MoreScreen(),
  EditProfilePage.routeName: (context) => EditProfilePage(),
};
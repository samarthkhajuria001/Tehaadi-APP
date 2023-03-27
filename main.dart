import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tehaadi/constants/colors.dart';
import 'package:tehaadi/screens/add_new_task.dart';
import 'package:tehaadi/screens/drawer_screen.dart';
import 'package:tehaadi/screens/edit_task_screen.dart';
import 'package:tehaadi/screens/feedback_screen.dart';
import 'package:tehaadi/screens/home_screen.dart';
import 'package:tehaadi/screens/login_screen.dart';
import 'package:tehaadi/screens/settings_screen.dart';
import 'package:tehaadi/screens/signup_screen.dart';
import 'package:tehaadi/services/authServices/auth_serviced.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: primaryBackgroudColor,
    ),
    routes: {
      drawerScreen: (context) => NavDrawer(),
      addNewTaskScreen: (context) => AddNewTaskScreen(),
      signUpScreen: (context) => SignUpScreen(),
      logInScreen: (context) => LogInScreen(),
      homeScreen: (context) => HomePage(),
      editTaskScreen: (context) => EditTaskScreen(),
      settingScreen: (context) => SettingScreen(),
      feedbackScreen: (context) => FeedbackScreen(),
    },
    home: StreamBuilder(
      stream: AuthServices.firebase().userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LogInScreen();
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ),
  ));
}

const taskScreen = '/taskscreen';
const drawerScreen = '/drawersreen';
const profileScreen = '/profileScreen';
const settingScreen = '/settingscreen';
const addNewTaskScreen = '/addnewtaskscreen';
const logInScreen = '/loginscreen';
const signUpScreen = '/signupscreen';
const homeScreen = '/homescreen';
const editTaskScreen = '/edittasksceen';
const feedbackScreen = 'feedbackscreen';

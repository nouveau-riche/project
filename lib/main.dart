import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/login_screen.dart';
import './screens/select_plan_screen.dart';
import './screens/my_profile.dart';
import './screens/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser != null ? TabScreen() : Authentication(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login-screen': (ctx) => Authentication(),
        '/tab-screen': (ctx) => TabScreen(),
        '/my-profile-screen': (ctx) => MyProfile(),
        '/select-plan-screen': (ctx) => SelectPlanScreen(),
      },
    );
  }
}



import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/authentication_screen/login_screen.dart';
import './screens/authentication_screen/password_screen.dart';
import './screens/chosse_service_screen/chosse_service.dart';
import './screens/authentication_screen/email_screen.dart';
import './screens/authentication_screen/reset-password-screen.dart';
import './screens/my_account_screen/my_profile.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser != null ? ChooseService() : Login(),
      debugShowCheckedModeBanner: false,
      routes: {
        'login-screen': (ctx) => Login(),
        '/email-screen': (ctx) => EmailScreen(),
        '/password-screen': (ctx) => PasswordScreen(),
        '/reset-password-screen': (ctx) => ResetPasswordScreen(),
        '/choose_service-screen': (ctx) => ChooseService(),
        '/my-profile-screen': (ctx) => MyProfile(),
      },
    );
  }
}



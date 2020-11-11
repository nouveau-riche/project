import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utility/Http_Exception.dart';
import '../database/database.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> signIn(BuildContext context, String email, String password) async {
  try {
    UserCredential _result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = _result.user;
    if (user != null) {
      Navigator.of(context).pushReplacementNamed('/choose_service-screen');
    }
  } catch (error) {
    print(error.toString());
    throw HttpException(error.toString());
  }
}

Future<void> signUp(
    BuildContext context, String email, String password) async {
  try {
    UserCredential _result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = _result.user;
    if (user != null) {
      saveUserInfo(uid: user.uid, email: email);
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/choose_service-screen', (route) => false);
    }
  } catch (error) {
    print(error.toString());
    throw HttpException(error.toString());
  }
}

Future<void> signOut() async {
  return await _auth.signOut();
}

Future resetPasswordWithEmail(String email) async {
  return _auth.sendPasswordResetEmail(email: email);
}

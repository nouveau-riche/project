import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../authentication/google_signin.dart';

Widget buildDrawerContent(BuildContext context) {
  final mq = MediaQuery.of(context).size;
  User user = FirebaseAuth.instance.currentUser;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: mq.height*0.05,
      ),
      Padding(
        padding: EdgeInsets.only(left: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoURL),
            ),
            const SizedBox(height: 5,),
            Text(user.displayName,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
          ],
        ),
      ),
      const Divider(
        color: Colors.grey,
      ),
      FlatButton.icon(
        icon: const Icon(Icons.rate_review),
        label: const Text('Rate us!'),
        onPressed: () {},
      ),
      FlatButton.icon(
        icon: const Icon(Icons.help),
        label: const Text('Help'),
        onPressed: () {},
      ),
      FlatButton.icon(
        icon: const Icon(Icons.call_missed),
        label: const Text('Logout'),
        onPressed: () {
          signOutGoogle();
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login-screen', (route) => false);
        },
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../authentication/google_signin.dart';


// remove comment

Widget buildDrawerContent(BuildContext context) {
  final mq = MediaQuery.of(context).size;
  //User user = FirebaseAuth.instance.currentUser;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 15),
        child: Container(
          width: mq.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white38, Colors.grey[400]],
            ),
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mq.height * 0.05,
                  ),

//                  CircleAvatar(
//                    radius: 45,
//                    backgroundColor: Colors.grey[200],
//                    child: CircleAvatar(
//                      radius: 40,
//                      backgroundImage: NetworkImage(user.photoURL),
//                    ),
//                  ),
                  const SizedBox(
                    height: 5,
                  ),
//                  Text(
//                    user.displayName,
//                    style: const TextStyle(
//                        fontSize: 15, fontWeight: FontWeight.w500),
//                  ),
                  const SizedBox(
                    height: 5,
                  ),
//                  Text(
//                    user.email,
//                    style: const TextStyle(
//                        fontSize: 15, fontWeight: FontWeight.w500),
//                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      FlatButton.icon(
        icon: FaIcon(FontAwesomeIcons.star),
        label: const Text(
          'Rate us!',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        onPressed: () {},
      ),
      FlatButton.icon(
        icon: const Icon(Icons.help),
        label: const Text(
          'Help',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        onPressed: () {},
      ),
      FlatButton.icon(
        icon: FaIcon(FontAwesomeIcons.personBooth,size: 22,),
        label: const Text(
          'About Us!',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        onPressed: () {},
      ),
      FlatButton.icon(
        icon: FaIcon(FontAwesomeIcons.signOutAlt),
        label: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        onPressed: () {
          signOutGoogle();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login-screen', (route) => false);
        },
      ),
      Spacer(),
      FlatButton.icon(
        icon: FaIcon(
          FontAwesomeIcons.solidHeart,
          color: Colors.redAccent,
        ),
        label: const Text('Build by Nikunj Sharma'),
        onPressed: () {
          signOutGoogle();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login-screen', (route) => false);
        },
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}

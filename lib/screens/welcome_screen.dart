import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Welcome extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: mq.height * 0.6,
            child: Image.asset('assets/images/welcome.jpg'),
          ),
          Text(
            user.displayName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Poppins'),
          ),
          FlatButton(
            child: const Text(
              'Continue',
              style: const TextStyle(color: Colors.lightBlue, fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/tab-screen', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

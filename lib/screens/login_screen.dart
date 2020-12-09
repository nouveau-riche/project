import 'package:flutter/material.dart';

import '../authentication/google_signin.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(92, 202, 250, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: mq.height*0.07,),
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Container(
              height: mq.height * 0.2,
              width: mq.width*0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60)
              ),
              child: Image.asset("assets/images/logo.jpeg",fit: BoxFit.cover,),
            ),
          ),
          Container(
            height: mq.height * 0.13,
            child: const Text(
              'OTG Carwash',
              style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            height: mq.height * 0.12,
            child: Center(
              child: const Text(
                'Welcome to OTG Carwash',
                style: const TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          isLoading == true ? CircularProgressIndicator() : Container(
            height: mq.height * 0.05,
            width: mq.width*0.5,
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: const Text(
                'GET STARTED',
                style: const TextStyle(
                    color: const Color.fromRGBO(25, 128, 58, 1), fontSize: 17),
              ),
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                signInWithGoogle(context);
                setState(() {
                  isLoading = false;
                });
              },
              color: Colors.white,
            ),
          ),
          const Spacer(),
          const Text(
            'By signing in you agree to share contact information with us.',
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}

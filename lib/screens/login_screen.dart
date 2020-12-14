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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white70, Color.fromRGBO(92, 202, 250, 1)],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: mq.height * 0.08,
            ),
            Container(
              height: mq.height * 0.35,
              width: mq.width * 0.8,
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
            Container(
              height: mq.height * 0.12,
              child: Center(
                child: const Text(
                  'Welcome to OTG Carwash!',
                  style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            isLoading == true
                ? CircularProgressIndicator()
                : Container(
                    height: mq.height * 0.05,
                    width: mq.width * 0.58,
                    child: RaisedButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      child: const Text(
                        'GET STARTED',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: const Text(
                'By signing in you agree to share contact information with us.',
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

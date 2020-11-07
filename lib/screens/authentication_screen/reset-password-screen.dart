import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../authentication/authenticate.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailController = TextEditingController();
  var isLoading = false;

  void showErrorScaffold(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              topRight: const Radius.circular(15),
              topLeft: const Radius.circular(15))),
      content: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w700, color: Colors.black, fontSize: 16),
      ),
      backgroundColor: Colors.redAccent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            buildInstructionContainer(mq.height * 0.07, mq.width),
            SizedBox(height: mq.height * 0.028),
            buildEmailField(mq.width * 0.85, mq.height * 0.032),
            SizedBox(height: mq.height * 0.028),
            isLoading
                ? SpinKitCubeGrid(
                    color: Colors.lightGreenAccent,
                  )
                : buildResetButton(mq.width * 0.85, mq.height * 0.055),
          ],
        ),
      ),
    );
  }

  Widget buildEmailField(double width, double margin) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: margin),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        controller: _emailController,
      ),
    );
  }

  Widget buildResetButton(double width, double height) {
    return SizedBox(
        width: width,
        height: height,
        child: RaisedButton(
          child: const Text(
            'Reset',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            String email = _emailController.text.trim();
            bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(email);

            if (emailValid) {
              try {
                resetPasswordWithEmail(email);
                Navigator.of(context).pushReplacementNamed('/login-screen');
              } catch (error) {
                showErrorScaffold('Something went Wrong!');
              }
            } else {
              showErrorScaffold('Enter Valid Email');
            }
          },
          color: Colors.lightGreenAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
  }

  Widget buildInstructionContainer(double height, double width) {
    return Container(
      height: height,
      width: width,
      color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'A password reset link will be sent to',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const Text(
                'this email',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

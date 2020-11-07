import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../authentication/authenticate.dart';
import '../../Http_Exception.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _passwordController = TextEditingController();

  var showPassword = false;
  var isValid = false;
  var isLoading = false;
  String _email;

  void snackBar(String text) {
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

  void _save(BuildContext context, String email, String password) async {
    setState(() {
      isLoading = true;
    });
    try {
      await signUp(context, email, password);
    } on HttpException catch (error) {
      var errorMessage = 'Failed! Try again Later';
      if (error.toString().contains('ERROR_WRONG_PASSWORD')) {
        errorMessage = 'Opps! Wrong Password';
      } else if (error.toString().contains('ERROR_TOO_MANY_REQUESTS')) {
        errorMessage = 'Too many requests. Try again Later!';
      } else if (error.toString().contains('ERROR_EMAIL_ALREADY_IN_USE')) {
        errorMessage = 'User Already Registered';
      }
      snackBar(errorMessage);
    } catch (error) {
      print(error);
      const errorMessage = 'Internet connection too slow';
      snackBar(errorMessage);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    setState(() {
      _email = data['email'];
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: mq.height * 0.025),
            Container(
              child: const Align(
                child: const Text(
                  'Create a password',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ),
            ),
            SizedBox(height: mq.height * 0.027),
            Container(
              child: const Align(
                child: const Text(
                  'For security, your password must be five characters',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
            ),
            Container(
              child: const Align(
                child: const Text(
                  'or more.',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
            ),
            SizedBox(height: mq.height * 0.027),
            buildPasswordField(mq.width * 0.85),
            SizedBox(height: mq.height * 0.027),
            buildNextButton(mq.width * 0.85, mq.height * 0.06),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordField(double width) {
    return Container(
      width: width,
      child: TextField(
        obscureText: showPassword ? false : true,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon: showPassword
                ? const Icon(Icons.visibility, color: Colors.white)
                : const Icon(Icons.visibility_off, color: Colors.white),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(1, 204, 254, 1),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        controller: _passwordController,
        onChanged: (_value) {
          if (_value.length > 4) {
            setState(() {
              isValid = true;
            });
          } else {
            setState(() {
              isValid = false;
            });
          }
        },
      ),
    );
  }

  Widget buildNextButton(double width, double height) {
    return isLoading
        ? SpinKitThreeBounce(color: Color.fromRGBO(1, 204, 254, 1),size: 40)
        : SizedBox(
            width: width,
            height: height,
            child: RaisedButton(
              child: const Text(
                'Next',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: isValid
                  ? () {
                      _save(_scaffoldKey.currentContext, _email,
                          _passwordController.text);
                    }
                  : () {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        duration: const Duration(seconds: 2),
                        shape: const RoundedRectangleBorder(
                            borderRadius: const BorderRadius.only(
                                topRight: const Radius.circular(15),
                                topLeft: const Radius.circular(15))),
                        content: const Text(
                          'Enter Password!',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                        backgroundColor: Colors.redAccent,
                      ));
                    },
              color: isValid ? Color.fromRGBO(1, 204, 254, 1) : Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ));
  }
}

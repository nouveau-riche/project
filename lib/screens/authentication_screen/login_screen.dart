import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../Http_Exception.dart';
import '../../authentication/authenticate.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;
  var isLoading = false;

  final _focusPassword = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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

  void _save() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState.save();
      String __email = _email.trim();
      String __password = _password.trim();
      try {
        await signIn(context, __email, __password);
      } on HttpException catch (error) {
        var errorMessage = 'Failed! Try again Later';
        if (error.toString().contains('ERROR_WRONG_PASSWORD')) {
          errorMessage = 'Opps! Wrong Password';
        } else if (error.toString().contains('ERROR_TOO_MANY_REQUESTS')) {
          errorMessage = 'Too many requests. Try again Later!';
        } else if (error.toString().contains('ERROR_USER_NOT_FOUND')) {
          errorMessage = 'User not Registered';
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
  }

  @override
  void dispose() {
    _focusPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: buildForm(),
      ),
    );
  }

  Widget buildForm() {
    final mq = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildLogo(mq.height * 0.28, mq.width * 0.7),
            SizedBox(height: mq.height * 0.022),
            buildEmailField(mq.width * 0.1),
            SizedBox(height: mq.height * 0.022),
            buildPasswordField(mq.width * 0.1),
            SizedBox(
              height: mq.height * 0.03,
            ),
            isLoading
                ? SpinKitThreeBounce(color: Color.fromRGBO(1, 204, 254, 1),size: 40)
                : buildLogInButton(mq.height * 0.054, mq.width * 0.8),
            buildResetPassword(),
            buildChangeAuthenticationMode(),
          ],
        ),
      ),
    );
  }

  Widget buildLogo(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/logo.jpeg'),
        fit: BoxFit.fill,
      )),
    );
  }

  Widget buildEmailField(double margin) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      child: TextFormField(
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromRGBO(1, 204, 254, 1), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            )),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_focusPassword);
        },
        // ignore: missing_return
        validator: (_value) {
          if (_value.isEmpty) {
            return 'Enter email';
          }
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(_value);
          if (!emailValid) {
            return 'Enter valid email';
          }
        },
        onSaved: (_value) {
          _email = _value;
        },
      ),
    );
  }

  Widget buildPasswordField(double margin) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      child: TextFormField(
        cursorColor: Colors.grey,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromRGBO(1, 204, 254, 1), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            )),
        focusNode: _focusPassword,
        // ignore: missing_return
        validator: (_value) {
          if (_value.isEmpty) {
            return 'Enter password';
          }
        },
        onSaved: (_value) {
          _password = _value;
        },
      ),
    );
  }

  Widget buildLogInButton(double height, double width) {
    return SizedBox(
      width: width,
      height: height,
      child: RaisedButton(
        color: Color.fromRGBO(1, 204, 254, 1),
        child: const Text(
          'Log In',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: _save,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget buildResetPassword() {
    return FlatButton(
      child: const Text(
        'Reset Password?',
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/reset-password-screen');
      },
    );
  }

  Widget buildChangeAuthenticationMode() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Don\'t have an account?'),
          FlatButton(
            child: const Text(
              'Sign up',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/email-screen');
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailController = TextEditingController();

  var isValid = false;
  var emailValid = true;
  String _username;

  @override
  void dispose() {
    _emailController.dispose();
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
                  'Add email address',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ),
            ),
            SizedBox(height: mq.height * 0.027),
            buildEmailField(mq.width * 0.85),
            SizedBox(height: mq.height * 0.027),
            buildNextButton(mq.width * 0.85, mq.height * 0.06),
          ],
        ),
      ),
    );
  }

  void clearTextField() {
    _emailController.clear();
    setState(() {
      isValid = false;
    });
  }

  Widget buildEmailField(double width) {
    return Container(
      width: width,
      child: TextField(
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: const TextStyle(color: Colors.grey),
          errorText: emailValid ? null : 'Enter valid email',
          errorStyle:
          emailValid ? null : const TextStyle(color: Colors.redAccent),
          suffixIcon: isValid
              ? IconButton(
            icon: const Icon(
              Icons.clear,
              color: Colors.grey,
            ),
            onPressed: clearTextField,
          )
              : null,
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
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        onChanged: (_value) {
          if (_value.length > 0) {
            setState(() {
              isValid = true;
            });
          } else {
            setState(() {
              isValid = false;
            });
          }
          if (!emailValid) {
            emailValid = true;
          }
        },
      ),
    );
  }

  Widget buildNextButton(double width, double height) {
    return SizedBox(
        width: width,
        height: height,
        child: RaisedButton(
          child: const Text(
            'Next',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: isValid
              ? () {
            var email = _emailController.text.trim();
            emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(email);
            if (emailValid) {
              Navigator.of(context).pushNamed('/password-screen',
                  arguments: {
                    'username': _username,
                    'email': _emailController.text.trim()
                  });
            } else {
              setState(() {
                emailValid = false;
              });
            }
          }
              : () {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              duration: const Duration(seconds: 2),
              shape: const RoundedRectangleBorder(
                  borderRadius: const BorderRadius.only(
                      topRight: const Radius.circular(15),
                      topLeft: const Radius.circular(15))),
              content: const Text(
                'Enter email!',
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 16),
              ),
              backgroundColor: Colors.redAccent,
            ));
          },
          color: isValid ? Color.fromRGBO(1, 204, 254, 1) : Colors.grey,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
  }
}

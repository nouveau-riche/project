import 'package:flutter/material.dart';

import '../authentication/authenticate.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Log Out'),
          onPressed: () {
            signOut().whenComplete(() => Navigator.of(context).pushNamedAndRemoveUntil('login-screen', (route) => false));
          },
        ),
      ),
    );
  }
}

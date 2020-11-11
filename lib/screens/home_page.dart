import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(92, 202, 250, 1),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/my-profile-screen');
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Text('nikunj')
        ],
      ),

    );
  }
}

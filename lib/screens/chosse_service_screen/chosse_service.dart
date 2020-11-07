import 'package:flutter/material.dart';

class ChooseService extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed('/my-profile-screen');
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey,
            ),
          ),
        ],
      ),
      drawer: Drawer(),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
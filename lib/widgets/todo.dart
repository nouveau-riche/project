import 'package:flutter/material.dart';

class ToDO extends StatelessWidget{
  final String toDoName;
  ToDO(this.toDoName);

  Widget build(BuildContext context){
    final mq = MediaQuery.of(context).size;
    return Container(
      height: mq.height*0.125,
      width: mq.width*0.3,
      decoration: BoxDecoration(
          color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Color.fromRGBO(1, 204, 254, 1),Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ),
      ),
      child: Column(
        children: [
          Text(toDoName,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
        ],
      ),
    );
  }

}
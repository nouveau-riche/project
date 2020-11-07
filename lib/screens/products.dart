import 'package:flutter/material.dart';

class Products extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 204, 254, 1),
      ),
      body: Column(
        children: [
          Text(
              'products'
          ),
        ],
      ),
    );
  }
}
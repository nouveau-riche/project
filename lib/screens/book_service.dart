import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/todo.dart';

class BookService extends StatefulWidget {
  @override
  _BookServiceState createState() => _BookServiceState();
}

class _BookServiceState extends State<BookService> {
  final String url =
      "https://www.carqueryapi.com/api/0.3/?callback=?&cmd=getModel&model=11459";

  void getData() async {
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    print(data);
  }

  int _value = 0;

  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 204, 254, 1),
      ),
      body: Column(
        children: [
          SizedBox(height: mq.height * 0.01),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            height: mq.height * 0.08,
            width: mq.width * 0.95,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _value,
                items: [
                  DropdownMenuItem(
                      child: Text("Select Car"),
                      value: 0
                  ),
                  DropdownMenuItem(
                      child: Text("Third Item"),
                      value: 1
                  ),
                  DropdownMenuItem(
                      child: Text("second Item"),
                      value: 2
                  ),
                  DropdownMenuItem(
                      child: Text("Third Item"),
                      value: 3
                  ),
                  DropdownMenuItem(
                      child: Text("Third Item"),
                      value: 4
                  ),
                ],
                onChanged: (value){
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: mq.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: ToDO('Periodic Car Service'),
                onTap: () {},
              ),
              InkWell(
                child: ToDO('Revival Packs'),
                onTap: () {},
              ),
              InkWell(
                child: ToDO('Body Repair'),
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: mq.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: ToDO('Tyres and Batteries'),
                onTap: () {},
              ),
              InkWell(
                child: ToDO('Fitments'),
                onTap: () {},
              ),
              InkWell(
                child: ToDO('Car AC'),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

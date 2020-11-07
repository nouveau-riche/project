import 'package:flutter/material.dart';

import '../widgets/todo.dart';
import './my_bookings.dart';
import './products.dart';
import './book_service.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 204, 254, 1),
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
      drawer: Drawer(),
      body: Column(
        children: [
          SizedBox(height: mq.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: ToDO('Book service'),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => BookService()));
                },
              ),
              InkWell(
                child: ToDO('My bookings'),
                onTap: () {

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => MyBooking()));
                },
              ),
              InkWell(
                child: ToDO('Products'),
                onTap: () {

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => Products()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

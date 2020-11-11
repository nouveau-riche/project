import 'package:flutter/material.dart';

import './home_page.dart';
import './book_car_wash.dart';
import './my_bookings.dart';
import './my_profile.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  PageController _controller;

  int pageIndex = 0;

  void selectPage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  onTapChangePage(int pageIndex) {
    _controller.animateToPage(pageIndex,
        duration: const Duration(microseconds: 400), curve: Curves.bounceInOut);
  }

  whenPageChanges(int index) {
    setState(() {
      this.pageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              HomePage(),
              BookCarWash(),
              MyBookings(),
              MyProfile(),
            ],
            controller: _controller,
            onPageChanged: onTapChangePage,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapChangePage,
        currentIndex: pageIndex,
        selectedItemColor: Color.fromRGBO(92, 202, 250, 1),
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Padding(
                padding: EdgeInsets.all(0),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.done),
              title: Padding(
                padding: EdgeInsets.all(0),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Padding(
                padding: EdgeInsets.all(0),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Padding(
                padding: EdgeInsets.all(0),
              ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/accounts.dart';
import './wash_plans.dart';
import './book_car_wash.dart';
import './my_bookings.dart';
import './accounts.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  PageController _controller;

  onTapChangePage(int pageIndex) {
    _controller.animateToPage(pageIndex,
        duration: const Duration(microseconds: 300), curve: Curves.bounceInOut);
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
              physics: NeverScrollableScrollPhysics(),
              children: [
                PlanScreen(),
                BookCarWash(),
                MyBookings(),
                Account()
              ],
              controller: _controller,
            ),
          ],
        ),
        bottomNavigationBar: FancyBottomNavigation(
          circleColor: const Color.fromRGBO(92, 202, 250, 1),
          inactiveIconColor: const Color.fromRGBO(92, 202, 250, 1),
          onTabChangedListener: (position) {
            setState(() {
              onTapChangePage(position);
            });
          },
          tabs: [
            TabData(iconData: FontAwesomeIcons.home, title: 'Home'),
            TabData(iconData: Icons.local_car_wash, title: 'Wash'),
            TabData(iconData: FontAwesomeIcons.calendarAlt, title: 'Bookings'),
            TabData(iconData: Icons.person, title: 'Account'),
          ],
        ));
  }
}

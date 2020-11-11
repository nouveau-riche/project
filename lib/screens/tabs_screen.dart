import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              buildHomePage(context),
              BookCarWash(),
              MyBookings(),
              MyProfile(),
            ],
            controller: _controller,
            onPageChanged: whenPageChanges,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapChangePage,
        currentIndex: pageIndex,
        selectedItemColor: Color.fromRGBO(92, 202, 250, 1),
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
                size: 30,
              ),
              title: Padding(
                padding: EdgeInsets.all(0),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.done,
                size: 30,
              ),
              title: Padding(
                padding: EdgeInsets.all(0),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                size: 30,
              ),
              title: Padding(
                padding: EdgeInsets.all(0),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 30,
              ),
              title: Padding(
                padding: EdgeInsets.all(0),
              ))
        ],
      ),
    );
  }

  Widget buildHomePage(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    List<Widget> subscriptions = [
      buildEachSubscription('Monthly', '600', 1, context),
      buildEachSubscription('Quaterly', '1600', 2, context),
      buildEachSubscription('Half Yearly', '3400', 3, context),
      buildEachSubscription('Yearly', '6800', 4, context)
    ];

    User user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(92, 202, 250, 1),
        title: Text(
          'OTG-Car Wash',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/my-profile-screen');
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
//                backgroundImage: user.photoURL == null
//                    ? NetworkImage(
//                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSIhDQEvLnsTd6ohE3LObS6IvIg9ENkuk8h1A&usqp=CAU')
//                    : NetworkImage(''),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: mq.height * 0.28,
            width: mq.width,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
              ),
              itemCount: 4,
              itemBuilder: (ctx, index) => subscriptions[index],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              onTapChangePage(1);
            },
            child: Container(
              height: mq.height * 0.15,
              width: mq.width * 0.45,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(92, 202, 250, 1),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [Colors.blue,Color.fromRGBO(92, 202, 250, 1)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight
                  ),

              ),
              child: Center(
                  child: Text(
                'Book Car wash',
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildEachSubscription(
    String type, String price, int index, BuildContext context) {
  final mq = MediaQuery.of(context).size;
  return Container(
    height: mq.height * 0.32,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(92, 202, 250, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(type,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold))
                    ],
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'INR',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$price /-',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Text(
                'Exterior - Dry Wash',
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              Text('Interior - Wet Wash (Twice/month)',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
              Text('Dashboard - Clean & Polish',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
              Text('Tyre - Tyre Polish',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
              Text('Windshield/ Glass - Glass Gloss spry',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 5,
              width:  index == 2 ? 6 : 5,
              decoration: BoxDecoration(
                  color: index == 1 ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(2)),
            ),
            SizedBox(
              width: 7,
            ),
            Container(
              height: 5,
              width:  index == 2 ? 6 :  5,
              decoration: BoxDecoration(
                  color: index == 2 ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(2)),
            ),
            SizedBox(
              width: 7,
            ),
            Container(
              height: 5,
              width:  index == 2 ? 6 : 5,
              decoration: BoxDecoration(
                  color: index == 3 ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(2)),
            ),
            SizedBox(
              width: 7,
            ),
            Container(
              height: 5,
              width:  index == 2 ? 6 : 5,
              decoration: BoxDecoration(
                  color: index == 4 ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ],
        ),
      ],
    ),
  );
}

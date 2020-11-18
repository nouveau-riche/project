import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './book_car_wash.dart';
import './my_bookings.dart';
import './my_profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              icon: const Icon(Icons.home,size: 25,),
              title: const Padding(
                padding: EdgeInsets.all(0),
              )
              ),
          const BottomNavigationBarItem(
              icon: const Icon(
                Icons.local_car_wash,
                size: 25,
              ),
              title: const Padding(
                padding: EdgeInsets.all(0),
              )),
          const BottomNavigationBarItem(
              icon: const Icon(
                Icons.history,
                size: 25,
              ),
              title: const Padding(
                padding: EdgeInsets.all(0),
              )),
          const BottomNavigationBarItem(
              icon: const Icon(
                Icons.person,
                size: 25,
              ),
              title: const Padding(
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
        title: const Text(
          'OTG-Car Wash',
          style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/my-profile-screen');
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: user.photoURL == null
                    ? NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSIhDQEvLnsTd6ohE3LObS6IvIg9ENkuk8h1A&usqp=CAU')
                    : NetworkImage(user.photoURL),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: mq.height * 0.34,
            width: mq.width,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                aspectRatio: 3 / 2,
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
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
                    height: mq.height * 0.15,
                    width: mq.width * 0.45,
                    child: Image.asset('assets/images/front.jpg',fit: BoxFit.cover,),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20,top: 5),
                  width: mq.width * 0.45,
                  child: const Text(
                    'Book Car Wash',
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
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
    margin: EdgeInsets.all(5),
    child: Column(
      mainAxisSize: MainAxisSize.min,
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
              Text(
                'INR',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '$price /-',
                style: TextStyle(fontSize: 20),
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
              width: index == 2 ? 6 : 5,
              decoration: BoxDecoration(
                  color: index == 1 ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(2)),
            ),
            SizedBox(
              width: 7,
            ),
            Container(
              height: 5,
              width: index == 2 ? 6 : 5,
              decoration: BoxDecoration(
                  color: index == 2 ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(2)),
            ),
            SizedBox(
              width: 7,
            ),
            Container(
              height: 5,
              width: index == 2 ? 6 : 5,
              decoration: BoxDecoration(
                  color: index == 3 ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(2)),
            ),
            SizedBox(
              width: 7,
            ),
            Container(
              height: 5,
              width: index == 2 ? 6 : 5,
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

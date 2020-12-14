import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  Animation slidingAnimation;
  Animation furtherDelayedSlidingAnimation;
  AnimationController slidingBoxAnimationController;

  ScrollController _hideButtonController;
  var _isVisible;

  @override
  initState() {
    super.initState();

    slidingBoxAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    furtherDelayedSlidingAnimation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: slidingBoxAnimationController,
            curve: Interval(0.42, 1, curve: Curves.fastOutSlowIn)));

    slidingBoxAnimationController.forward();

    _isVisible = true;
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
  }

  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAppbar(user.photoURL),
          _isVisible
              ? Container(
                  child: Text(
                    'My Bookings',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                )
              : SizedBox(
                  height: 20,
                ),
          AnimatedBuilder(
            animation: slidingBoxAnimationController,
            builder: (BuildContext context, Widget child) {
              return Flexible(
                fit: FlexFit.loose,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('transcations')
                      .doc(user.uid)
                      .collection('allTranscation')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      isLoading = true;

                      var _data = snapshot.data;
                      List<Widget> package = [];
                      _data.docs.map((doc) {
                        package.add(
                          Transform(
                            transform: Matrix4.translationValues(
                                furtherDelayedSlidingAnimation.value * mq.width,
                                0.0,
                                0.0),
                            child: buildHistory(
                                context,
                                doc['transactionId'],
                                (doc['amount'] / 100).toInt(),
                                doc['carName'],
                                doc['carModel'],
                                doc['carNumber'],
                                doc['timestamp'].toDate(),
                                doc['success']),
                          ),
                        );
                      }).toList();

                      isLoading = false;

                      return isLoading
                          ? buildShimmer()
                          : (package.length == 0
                              ? buildNoBookingsDone()
                              : ListView(
                                  shrinkWrap: true,
                                  controller: _hideButtonController,
                                  children: package,
                                ));
                    } else {
                      return buildNoBookingsDone();
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget buildAppbar(String photoUrl) {
  return Container(
    child: Stack(
      children: [
        Image.asset(
          "assets/images/appbar.jpg",
          fit: BoxFit.cover,
        ),
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const Icon(
            Icons.subject,
            color: Colors.transparent,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: photoUrl == null
                    ? NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSIhDQEvLnsTd6ohE3LObS6IvIg9ENkuk8h1A&usqp=CAU')
                    : NetworkImage(photoUrl),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildHistory(
    BuildContext context,
    String paymentId,
    int amount,
    String carName,
    String carModel,
    String carNumber,
    DateTime timestamp,
    bool isPaymentSuccessfull) {
  final mq = MediaQuery.of(context).size;

  var date1 = timestamp.add(Duration(
    days: amount == 100
        ? 0
        : (amount == 600
            ? 30
            : (amount == 1600 ? 90 : (amount == 3400 ? 180 : 365))),
    hours: 0,
    minutes: 0,
    seconds: 0,
  ));

  final DateFormat formatterEndDate = DateFormat('yMEd');
  final String formattedEndDate = formatterEndDate.format(date1);

  final DateFormat formatter = DateFormat('yMEd');
  final String formatted = formatter.format(timestamp);

  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.only(
        left: mq.width * 0.02, right: mq.width * 0.02, top: mq.height * 0.01),
    child: Container(
      padding: EdgeInsets.all(mq.width * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white38, Colors.grey[300]],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/images.png'),
              ),
              const SizedBox(
                width: 10,
              ),
              amount == 100
                  ? const Text(
                      'Instant Car Wash',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  : amount == 600
                      ? const Text(
                          'Monthly Plan',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )
                      : amount == 1600
                          ? const Text(
                              'Quaterly Plan',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )
                          : amount == 3400
                              ? const Text(
                                  'Half Yearly',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )
                              : const Text(
                                  'Yearly plan',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
              const Spacer(),
              Container(
                height: 30,
                width: 1,
                color: Colors.black,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '$amount Rs',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Name: ',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text(carName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Model: ',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text(carModel,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Number: ',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text(carNumber,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Payment ID: ',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text('$paymentId',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Date of purchase: ',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15)),
                      Text('$formatted',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Plan End Date: ',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15)),
                      Text('$formattedEndDate',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14)),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              isPaymentSuccessfull
                  ? const Padding(
                      padding: EdgeInsets.all(0),
                    )
                  : const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 42,
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildShimmer() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Expanded(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: ListView.builder(
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48.0,
                    height: 48.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: 40.0,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            itemCount: 6,
          ),
        ),
      )
    ]),
  );
}

Widget buildNoBookingsDone() {
  return Center(
    child: Text('No bokkings done!'),
  );
}

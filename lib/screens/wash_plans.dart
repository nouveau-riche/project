import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../widgets/drawer.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';


// remove comments

class PlanScreen extends StatefulWidget {
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  //User user = FirebaseAuth.instance.currentUser;

  ScrollController _hideButtonController;
  var _isVisible;

  @override
  initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      buildContainer(context, 'Instant Wash', 0, '100'),
      buildContainer(context, 'Monthly', 1, '600'),
      buildContainer(context, 'Quaterly', 3, '1600'),
      buildContainer(context, 'Half Yearly', 6, '3400'),
      buildContainer(context, 'Yearly', 12, '6800'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(child: buildDrawerContent(context)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/appbar.jpg",
                  fit: BoxFit.cover,
                ),
                AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage:
                             NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSIhDQEvLnsTd6ohE3LObS6IvIg9ENkuk8h1A&usqp=CAU')
                            // NetworkImage(user.photoURL),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _isVisible
              ? Container(
                  child: Text(
                    'Our Plans',
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
          Expanded(
            child: ListView.builder(
              controller: _hideButtonController,
              shrinkWrap: true,
              itemBuilder: (ctx, index) => list[index],
              itemCount: 5,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}




Widget buildContainer(
    BuildContext context, String type, double duration, String cost) {
  final mq = MediaQuery.of(context).size;

  Map<String, double> dataMap = {'Duration': duration, 'Total Duration': 12};

  return Container(
    height: mq.height * 0.32,
    width: mq.width,
    margin: EdgeInsets.symmetric(horizontal: mq.width*0.018, vertical: 5),
    padding: EdgeInsets.only(left: mq.width*0.022, right: mq.width*0.022, top: 5),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: const BorderRadius.only(topRight: Radius.circular(100)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white38, Colors.grey[300]],
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 20,
                          width: 5,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(92, 202, 250, 1),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$cost Rs',
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 20,
                          width: 5,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(92, 202, 250, 1),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Exterior - Wet Wash',
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 20,
                          width: 5,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(92, 202, 250, 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Interior - Dry Wash',
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: mq.height * 0.16,
              width: mq.width * 0.4,
              child: PieChart(
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 0,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                colorList: [
                  const Color.fromRGBO(92, 202, 250, 1),
                  Colors.white70
                ],
                initialAngleInDegree: 90,
                chartType: ChartType.ring,
                ringStrokeWidth: 15,
                centerText: type,
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: false,
                  legendShape: BoxShape.circle,
                  legendTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: false,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                ),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.black87,
        ),
        Expanded(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/images/windshield.png'),
                    ),
                    const Text(
                      'Glass Spray',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100),
                          topLeft: Radius.circular(100)),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(100),
                              topLeft: Radius.circular(100)),
                        ),
                        child: Image.asset('assets/images/tyre.jpg'),
                      ),
                    ),
                    const Text(
                      'Tyre Polish',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '2',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontSize: 28),
                    ),
                    const Text(
                      'Times/Month',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';


import '../widgets/drawer.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlanScreen extends StatelessWidget{

  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context){

    List<Widget> list = [
      buildContainer(context, 'Instant Wash', 0, '100'),
      buildContainer(context, 'Monthly', 1, '600'),
      buildContainer(context, 'Quaterly', 3, '1600'),
      buildContainer(context, 'Half Yearly', 6, '3400'),
      buildContainer(context, 'Yearly', 12, '6800'),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(92, 202, 250, 1),
        title: const Text(
          'OTG-Car Wash',
          style: const TextStyle(
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: user.photoURL == null
                  ? NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSIhDQEvLnsTd6ohE3LObS6IvIg9ENkuk8h1A&usqp=CAU')
                  : NetworkImage(user.photoURL),
            ),
          ),
        ],
      ),
      drawer: Drawer(child: buildDrawerContent(context)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (ctx, index) => list[index],
              itemCount: 5,
            ),
          ),
//          GestureDetector(
//            onTap: () {
//              onTapChangePage(1);
//            },
//            child: Column(
//              children: [
//                ClipRRect(
//                  borderRadius: BorderRadius.circular(14),
//                  child: Container(
//                    decoration:
//                        BoxDecoration(borderRadius: BorderRadius.circular(14)),
//                    height: mq.height * 0.15,
//                    width: mq.width * 0.45,
//                    child: Image.asset(
//                      'assets/images/front.jpg',
//                      fit: BoxFit.cover,
//                    ),
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.only(left: 20, top: 5),
//                  width: mq.width * 0.45,
//                  child: const Text(
//                    'Book Car Wash',
//                    style: const TextStyle(
//                        fontSize: 20,
//                        fontFamily: 'poppins',
//                        fontWeight: FontWeight.bold),
//                  ),
//                )
//              ],
//            ),
//          ),
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
    height: mq.height * 0.30,
    width: mq.width,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: const BorderRadius.only(topRight: Radius.circular(100)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                height: mq.height * 0.18,
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
              height: mq.height * 0.18,
              width: mq.width * 0.45,
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
        Row(
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
                Container(
                  height: 40,
                  width: 40,
                  child: Image.asset('assets/images/tyre.jpg'),
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
                      fontSize: 30),
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
      ],
    ),
  );
}



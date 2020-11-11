import 'package:flutter/material.dart';

class SelectPlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(92, 202, 250, 1),
        title: Text('Select Plan'),
      ),
      body: ListView(
        children: [
          buildPackage(mq.width * 0.95, mq.height * 0.2, 'Wash Instantly', 100,
              'assets/images/image1.jpeg'),
          buildPackage(mq.width * 0.95, mq.height * 0.2, 'Monthly', 600,
              'assets/images/image2.jpg'),
          buildPackage(mq.width * 0.95, mq.height * 0.2, 'Quaterly', 1600,
              'assets/images/image3.jpg'),
          buildPackage(mq.width * 0.95, mq.height * 0.2, 'Half Yearly', 3400,
              'assets/images/image4.jpg'),
          buildPackage(mq.width * 0.95, mq.height * 0.2, 'Yearly', 6800,
              'assets/images/image1.jpeg'),
        ],
      ),
    );
  }

  Widget buildPackage(
      double width, double height, String plan, int cost, String image) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.all(10),
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: height,
                width: width,
                child: Image.asset(image, fit: BoxFit.fill),
              ),
            ),
            Column(
              children: [
                Text(
                  plan,
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Nunito'),
                ),
                Text(
                  '$cost',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Nunito'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

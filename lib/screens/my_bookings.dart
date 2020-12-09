import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class MyBookings extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My bookings',
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(92, 202, 250, 1),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('transcations')
            .doc(user.uid)
            .collection('allTranscation')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _data = snapshot.data;
            List package = [];

            _data.docs.map((doc) {
              package.add(
                buildHistory(
                    mq.height * 0.34,
                    doc['transactionId'],
                    (doc['amount'] / 100).toInt(),
                    doc['carName'],
                    doc['carModel'],
                    doc['carNumber'],
                    doc['timestamp'],
                    doc['success']),
              );
            }).toList();
            return package.length == 0
                ? buildShimmer()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: package.length,
                    itemBuilder: (ctx, index) => package[index]);
          } else {
            return buildShimmer();
          }
        },
      ),
    );
  }
}

Widget buildHistory(
    double height,
    String paymentId,
    int amount,
    String carName,
    String carModel,
    String carNumber,
    Timestamp timestamp,
    bool isPaymentSuccessfull) {
  final DateFormat formatter = DateFormat('MMMEd');
  final String formatted = formatter.format(timestamp.toDate());

  return Card(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.only(left: 14, right: 14, top: 20),
    child: Container(
      padding: const EdgeInsets.all(20),
      height: height,
      decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: const Color.fromRGBO(92, 202, 250, 1),
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200]),
      child: Column(
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
              const Text(
                'Name: ',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: isPaymentSuccessfull
                      ? Image.asset('assets/images/payment_success.png')
                      : Image.asset('assets/images/payment_failed.jpg'),
                ),
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

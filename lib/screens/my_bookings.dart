import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:timeago/timeago.dart' as timeago;

class MyBookings extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('My bookings'),
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
              package.add(buildSingleTransaction(
                  doc['transactionId'], doc['amount'], doc['timestamp']));
            }).toList();
            return ListView.builder(
                shrinkWrap: true,
                itemCount: package.length,
                itemBuilder: (ctx, index) => package[index]);
          } else {
            return Text('no history');
          }
        },
      ),
    );
  }
}

Widget buildSingleTransaction(
    String paymentId, int amount, Timestamp timestamp) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    height: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.lightGreen,
    ),
    child: Column(
      children: [
        Text('Payment ID: $paymentId'),
        Text('Amount: $amount'),
        amount == 100
            ? Text('Plan: Instant Car Wash')
            : amount == 600
                ? Text('Plan: Monthly Plan')
                : amount == 1600
                    ? Text('Plan: Quaterly Paln')
                    : amount == 3400
                        ? Text('Plan: Half Yearly')
                        : Text('Plan: Yearly plan'),
        Text(timeago.format(timestamp.toDate())),
        Text('Date of purchase: ${timestamp.toDate()}'),
      ],
    ),
  );
}

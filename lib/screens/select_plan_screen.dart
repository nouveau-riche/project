import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../database/database.dart';

class SelectPlanScreen extends StatefulWidget {
  @override
  _SelectPlanScreenState createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends State<SelectPlanScreen> {
  User user = FirebaseAuth.instance.currentUser;
//
//  Razorpay _razorpay;
//
//  @override
//  void initState() {
//    super.initState();
//
//    _razorpay = new Razorpay();
//
//    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
//    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
//    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _razorpay.clear();
//  }
//
//  var options = {
//    'key': 'rzp_test_UGeWcmJMvhckq1',
//    'amount': 0,
//    'name': 'OTG-Carwash',
//    'description': 'description',
//    'prefill': {'contact': '', 'email': 'user.email'},
//    'external': {
//      'wallets': ['Paytm']
//    },
//  };
//
//  void openCheckout(int amount, String description) {
//    options['amount'] = amount;
//    options['description'] = description;
//    options['prefill'] = {'contact': '','email': user.email};
//
//    try {
//      _razorpay.open(options);
//    } catch (error) {
//      print(error.toString());
//    }
//  }
//
//   handlerPaymentSuccess(PaymentSuccessResponse response) {
//    print(
//        'dnvjdfldkjf djhf jdhfoifere rbejreroejrherheifjefhwkjfoifjheiofjenfejfhewiofjefefjehf shnvxjbvjkxhviodjfkjbvfjkhowieproqwejhifbjkd');
//    print(options['amount']);
//    uploadTransactionOnFirebase(user.uid, response.paymentId,options['amount']);
//    //Fluttertoast.showToast(msg: 'Payment successful');
//  }
//
//  void handlerErrorFailure() {
//    print(
//        'dnvjdfldkjf djhf jdhfoifere rbejreroejrherheifjefhwkjfoifjheiofjenfejfhewiofjefefjehf shnvxjbvjkxhviodjfkjbvfjkhowieproqwejhifbjkd');
//    print('Payment failure');
//    //Fluttertoast.showToast(msg: 'Payment Failure');
//  }
//
//  void handlerExternalWallet() {
//    print('external wallet');
//  }

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
      onTap: () {
        //openCheckout(cost, plan);
      },
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

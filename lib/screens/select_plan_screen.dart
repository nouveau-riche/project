import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../database/database.dart';

class SelectPlanScreen extends StatefulWidget {
  final String carName;
  final String carModel;
  final String carNumber;

  SelectPlanScreen({this.carName, this.carModel, this.carNumber});

  @override
  _SelectPlanScreenState createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends State<SelectPlanScreen> {
  User user = FirebaseAuth.instance.currentUser;

  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    _razorpay = new Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  var options = {
    'key': 'rzp_test_UGeWcmJMvhckq1',
    'amount': 0,
    'name': 'OTG-Carwash',
    'description': 'description',
    'prefill': {'contact': '', 'email': 'user.email'},
    'external': {
      'wallets': ['Paytm']
    },
  };

  void openCheckout(int amount, String description) {
    options['amount'] = amount * 100;
    options['description'] = description;
    options['prefill'] = {'contact': '', 'email': user.email};

    try {
      _razorpay.open(options);
    } catch (error) {
      print(error.toString());
    }
  }

  handlerPaymentSuccess(PaymentSuccessResponse response) {
    print(options['amount']);
    uploadTransactionOnFirebase(
        uid: user.uid,
        transactionId: response.paymentId,
        amount: options['amount'],
        carName: widget.carName,
        carModel: widget.carModel,
        carNumber: widget.carNumber,
        isSuccessful: true);
    //Fluttertoast.showToast(msg: 'Payment successful');
  }

  void handlerErrorFailure(PaymentFailureResponse failureResponse) {
    uploadTransactionOnFirebase(
        uid: user.uid,
        transactionId: 'failed',
        amount: options['amount'],
        carName: widget.carName,
        carModel: widget.carModel,
        carNumber: widget.carNumber,
        isSuccessful: false);
    //Fluttertoast.showToast(msg: 'Payment Failure');
  }

  void handlerExternalWallet() {
    print('external wallet');
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
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
                        backgroundImage: NetworkImage(user.photoURL),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: const Text(
              'Choose Plan',
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          Expanded(
            child: ListView(
              children: [
                buildPackage(mq.width * 0.95, 'Wash Instantly', 100,
                    'assets/images/image1.jpeg', '4.8'),
                buildPackage(mq.width * 0.95, 'Monthly', 600,
                    'assets/images/image2.jpg', '4.5'),
                buildPackage(mq.width * 0.95, 'Quaterly', 1600,
                    'assets/images/image3.jpg', '4.9'),
                buildPackage(mq.width * 0.95, 'Half Yearly', 3400,
                    'assets/images/image4.jpg', '4.1'),
                buildPackage(mq.width * 0.95, 'Yearly', 6800,
                    'assets/images/image1.jpeg', '5.0'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPackage(
      double width, String plan, int cost, String image, String rating) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: buildContainer(context, plan, rating, cost),
    );
  }

  Widget buildContainer(
      BuildContext context, String plan, String rating, int cost) {
    final mq = MediaQuery.of(context).size;
    return Container(
      height: mq.height * 0.24,
      width: mq.width * 0.95,
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Align(
            child: Container(
              height: mq.height * 0.22,
              width: mq.width * 0.8,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(92, 202, 250, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: mq.width * 0.65,
                    child: ListTile(
                      title: Text(
                        plan,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1),
                      ),
                      subtitle: GestureDetector(
                        onTap: () {
                          buildFeatureDialogBox();
                        },
                        child: const Text(
                          'See Features',
                          style: const TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.1,
                              fontSize: 16),
                        ),
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.star,
                            color: const Color.fromRGBO(253, 187, 103, 1),
                          ),
                          Text(
                            rating,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * 0.024,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 5),
                    width: mq.width * 0.72,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '$cost Rs',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1.1),
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                        SizedBox(
                          width: mq.width * 0.22,
                          height: 32,
                          child: RaisedButton(
                            child: const Text(
                              'Book',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              openCheckout(cost, plan);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            alignment: Alignment.bottomRight,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
              child: Container(
                height: mq.height * 0.12,
                width: mq.width * 0.24,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(216, 216, 216, 1),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(10)),
                ),
                child: Image.asset(
                  'assets/images/plan_sticker.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildFeatureDialogBox() {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text(
                'Features',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Exterior - Dry Wash',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const Text('Interior - Wet Wash (Twice/month)',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16)),
                  const Text('Dashboard - Clean & Polish',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const Text('Tyre - Tyre Polish',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16)),
                  const Text('Windshield/ Glass - Glass Gloss spry',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16)),
                ],
              ),
              actions: [
                FlatButton(
                  child: const Text(
                    'Close',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}

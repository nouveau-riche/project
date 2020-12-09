import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import './my_bookings.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _nameController = TextEditingController();

  var isLoading = false;
  User user = FirebaseAuth.instance.currentUser;

  showSnackBar(String text) {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(
        text,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      backgroundColor: Color.fromRGBO(1, 204, 254, 1),
      shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              topRight: const Radius.circular(10),
              topLeft: const Radius.circular(10))),
    ));
  }

  Future getUserStoredDetails() async {
    final ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    await ref.then((value) {
      _nameController.text = value.data()['name'];
    });
  }

  Future updateUserInfo() async {
    final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);
    await ref.update({
      'name': _nameController.text.trim(),
    });
    showSnackBar('Profile Changed Successfully!');
  }

  @override
  void initState() {
    super.initState();
    getUserStoredDetails();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(1, 204, 254, 1),
        title: const Text(
          'Edit Profile',
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: isLoading
                ? SpinKitThreeBounce(
                    color: const Color.fromRGBO(1, 204, 254, 1), size: 40)
                : const Icon(Icons.done, size: 36),
            onPressed: isLoading
                ? () {}
                : () {
                    setState(() {
                      isLoading = true;
                    });
                    updateUserInfo();
                    setState(() {
                      isLoading = false;
                    });
                  },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: mq.height * 0.028),
            buildImageContainer(),
//            isProfileLoading
//                ? Column(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                SizedBox(height: mq.height * 0.02),
//                const CircularProgressIndicator(
//                    backgroundColor: const Color.fromRGBO(1, 204, 254, 1)),
//              ],
//            )
//                : buildChangePhoto(),
            buildNameField(),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Text(
                    'History',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
            buildHistoryStream(),
//            SizedBox(
//              height: 20,
//            ),
            //buildLogOut(mq.width * 0.95),
          ],
        ),
      ),
    );
  }

  Widget buildHistoryStream() {
    final mq = MediaQuery.of(context).size;
    User user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('transcations')
          .doc(user.uid)
          .collection('allTranscation')
          .orderBy('timestamp', descending: true)
          .limit(2)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var _data = snapshot.data;
          List<Widget> package = [];

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
          return Column(
            children: package,
          );
        } else {
          return Text('no history');
        }
      },
    );
  }

  Widget buildNameField() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        cursorColor: Colors.grey,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            labelText: 'Name',
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            enabledBorder: const UnderlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.grey)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: const BorderSide(
                    width: 2, color: Color.fromRGBO(1, 204, 254, 1)))),
        controller: _nameController,
      ),
    );
  }

//  Widget buildChangePhoto() {
//    return FlatButton(
//        child: const Text('Change Photo',
//            style: const TextStyle(
//                color: const Color.fromRGBO(1, 204, 254, 1),
//                fontWeight: FontWeight.bold,
//                fontSize: 16)),
//        onPressed: () {
//          openDialogBox('photoUrl');
//        });
//  }

//  openDialogBox(String updateType) {
//    showDialog(
//        context: context,
//        builder: (ctx) =>
//            SimpleDialog(
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(10)),
//              children: <Widget>[
//                SimpleDialogOption(
//                    child: const Text(
//                      "Capture Image with Camera",
//                    ),
//                    onPressed: () {
//                      captureImageFromCamera(updateType);
//                    }),
//                SimpleDialogOption(
//                    child: const Text(
//                      "Pick Image from Gallery",
//                    ),
//                    onPressed: () {
//                      pickImageFromGallery(updateType);
//                    }),
//                SimpleDialogOption(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.end,
//                      children: <Widget>[
//                        const Icon(
//                          Icons.cancel,
//                          color: Colors.grey,
//                        ),
//                        const Text(
//                          "Cancel",
//                        ),
//                      ],
//                    ),
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    }),
//              ],
//            ));
//  }

  buildImageContainer() {
    User user = FirebaseAuth.instance.currentUser;
    return Center(
      child: GestureDetector(
        onTap: () {
          //openDialogBox('photoUrl');
        },
        child: CircleAvatar(
          backgroundColor: Colors.white70,
          radius: 45,
          backgroundImage: NetworkImage(user.photoURL),
        ),
      ),
    );
  }

//  Widget buildLogOut(double width) {
//    return SizedBox(
//      width: width,
//      child: OutlineButton(
//          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
//          shape:
//              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//          child: const Text(
//            'Log Out',
//            style: const TextStyle(
//                color: Colors.redAccent,
//                fontSize: 17,
//                fontWeight: FontWeight.w600),
//          ),
//          onPressed: () {
//            signOutGoogle();
//            Navigator.of(context)
//                .pushNamedAndRemoveUntil('/login-screen', (route) => false);
//          }),
//    );
//  }
}

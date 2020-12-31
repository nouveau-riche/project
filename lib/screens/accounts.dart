import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../database/database.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final User user = FirebaseAuth.instance.currentUser;

  bool isLoading = false;

  TextEditingController _phoneController;
  TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    final ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    await ref.then((value) {
      _phoneController = TextEditingController(text: value.data()['contact']);
      _addressController = TextEditingController(text: value.data()['address']);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mq.height * 0.1,
            ),
            buildCircleAvatar(),
            SizedBox(
              height: mq.height * 0.08,
            ),
            buildPhoneNumberField(mq.width * 0.8),
            buildAddressField(mq.width * 0.8),
            isLoading ? CircularProgressIndicator() : buildUpdateDetails()
          ],
        ),
      ),
    );
  }

  Widget buildCircleAvatar() {
    return CircleAvatar(
      radius: 65,
      backgroundColor: Colors.grey[400],
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(user.photoURL),
      ),
    );
  }

  Widget buildPhoneNumberField(double width) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        decoration: InputDecoration(hintText: 'Phone Number'),
        keyboardType: TextInputType.number,
        controller: _phoneController,
      ),
    );
  }

  Widget buildAddressField(double width) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        decoration: InputDecoration(hintText: 'Address'),
        controller: _addressController,
      ),
    );
  }

  Widget buildUpdateDetails() {
    return RaisedButton(
      elevation: 0,
      child: const Text('Update'),
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        updateDetails(user.uid, _phoneController.text, _addressController.text);
        Fluttertoast.showToast(msg: 'Updated successfully');
        setState(() {
          isLoading = false;
        });
      },
    );
  }
}

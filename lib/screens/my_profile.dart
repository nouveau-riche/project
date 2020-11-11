import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../authentication/authenticate.dart';
import '../database/database.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _nameController = TextEditingController();

  var isLoading = false;
  var isProfileLoading = false;
  String userPhoto;

  File image;
  final picker = ImagePicker();

  User user = FirebaseAuth.instance.currentUser;

  Future captureImageFromCamera(String updateType) async {
    Navigator.of(context).pop();
    final imageFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      isProfileLoading = true;
    });
    if (imageFile != null) {
      setState(() {
        image = File(imageFile.path);
      });
      String url = await uploadImageToFirebaseStorage(user.uid, image);
      final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);
      user.updateProfile(photoURL: url);
      await ref.update({
        updateType: url,
      });
      getUserStoredDetails();
      showSnackBar();
    }
    setState(() {
      isProfileLoading = false;
    });
  }

  Future pickImageFromGallery(String updateType) async {
    Navigator.of(context).pop();
    final imageFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      isProfileLoading = true;
    });
    if (imageFile != null) {
      setState(() {
        image = File(imageFile.path);
      });
      String url = await uploadImageToFirebaseStorage(user.uid, image);
      final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);
      user.updateProfile(photoURL: url);
      await ref.update({
        updateType: url,
      });
      getUserStoredDetails();
      showSnackBar();
    }
    setState(() {
      isProfileLoading = false;
    });
  }

  showSnackBar() {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: const Text(
        'Photo Changed Successfully!',
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
      setState(() {
        userPhoto = value.data()['photoUrl'];
      });
      _nameController.text = value.data()['name'];
    });
  }

  Future updateUserInfo() async {
    final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);
    await ref.update({
      'name': _nameController.text.trim(),
    });
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
        backgroundColor: Color.fromRGBO(1, 204, 254, 1),
        title: const Text('Edit Profile'),
        actions: <Widget>[
          IconButton(
            icon: isLoading
                ? SpinKitThreeBounce(
                    color: Color.fromRGBO(1, 204, 254, 1), size: 40)
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
                    Navigator.of(context).pop();
                  },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: mq.height * 0.028),
            buildImageContainer(),
            isProfileLoading
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: mq.height * 0.02),
                      const CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(1, 204, 254, 1)),
                    ],
                  )
                : buildChangePhoto(),
            buildNameField(),
            buildLogOut(mq.width*0.5)
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        cursorColor: Colors.grey,
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

  Widget buildChangePhoto() {
    return FlatButton(
        child: const Text('Change Photo',
            style: const TextStyle(
                color: Color.fromRGBO(1, 204, 254, 1),
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        onPressed: () {
          openDialogBox('photoUrl');
        });
  }

  openDialogBox(String updateType) {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              children: <Widget>[
                SimpleDialogOption(
                    child: const Text(
                      "Capture Image with Camera",
                    ),
                    onPressed: () {
                      captureImageFromCamera(updateType);
                    }),
                SimpleDialogOption(
                    child: const Text(
                      "Pick Image from Gallery",
                    ),
                    onPressed: () {
                      pickImageFromGallery(updateType);
                    }),
                SimpleDialogOption(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                        const Text(
                          "Cancel",
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ));
  }

  buildImageContainer() {
    return Center(
      child: GestureDetector(
        onTap: () {
          openDialogBox('photoUrl');
        },
        child: CircleAvatar(
          backgroundColor: Colors.white70,
          radius: 45,
          backgroundImage: userPhoto != null
              ? NetworkImage(userPhoto)
              : NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSIhDQEvLnsTd6ohE3LObS6IvIg9ENkuk8h1A&usqp=CAU'),
        ),
      ),
    );
  }

  Widget buildLogOut(double width) {
    return SizedBox(
      width: width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Text('Log Out'),
        onPressed: () {
          signOut().whenComplete(() => Navigator.of(context)
              .pushNamedAndRemoveUntil('/login-screen', (route) => false));
        },
      ),
    );
  }
}

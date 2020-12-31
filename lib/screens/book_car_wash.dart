import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './select_plan_screen.dart';
import '../constant/const.dart';

class BookCarWash extends StatefulWidget {
  @override
  _BookCarWashState createState() => _BookCarWashState();
}

class _BookCarWashState extends State<BookCarWash> {
  int _valueCarName = 0;
  int _valueCarModel = 0;
  int _valuePinCode = 0;
  String contact;
  String address;
  TextEditingController _controller = TextEditingController();

  var isLoading = false;

  User user = FirebaseAuth.instance.currentUser;

  void initState() {
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    final ref =
        FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    await ref.then((value) {
      contact = value.data()['contact'];
      address = value.data()['address'];
      setState(() {});
    });
  }

  List<DropdownMenuItem> modelDropDown = [
    DropdownMenuItem(
      child: const Text(
        'Select Car Model',
        style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black),
      ),
      value: 0,
    ),
  ];

  fetchData(String name) {
    _valueCarModel = 0;
    setState(() {
      isLoading = true;
    });

    modelDropDown = [
      DropdownMenuItem(
        child: const Text(
          'Select Car Model',
          style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        value: 0,
      ),
    ];

    List<String> list = [];
    list = carModel[name];

    int i = 1;

    list.forEach((element) {
      modelDropDown.add(
        DropdownMenuItem(
          child: Text(
            element,
            style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          value: i,
        ),
      );
      i++;
    });

    setState(() {
      isLoading = false;
    });
  }

  List<DropdownMenuItem> items = [
    DropdownMenuItem(
      child: const Text(
        'Select Car',
        style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black),
      ),
      value: 0,
    ),
  ];
  bool carNameFetched = false;
  int i = 1;

  void fun() {
    carNames.forEach((element) {
      items.add(
        DropdownMenuItem(
          child: Text(
            element,
            style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          value: i,
        ),
      );
      i++;
    });
    setState(() {
      carNameFetched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!carNameFetched) {
      fun();
    }

    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  height: mq.height * 0.4,
                  width: mq.width,
                  child: Image.asset(
                    'assets/images/sticker.jpg',
                    fit: BoxFit.cover,
                  ))),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: mq.height * 0.55,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text(
                      'Select Vehicle',
                      style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  buildPinCodeDropDown(mq.height * 0.06, mq.width * 0.8),
                  buildCarNameSelectingDropDown(
                      mq.height * 0.06, mq.width * 0.8),
                  if (_valueCarName != 0)
                    isLoading == true
                        ? CircularProgressIndicator()
                        : buildCarModelSelectingDropDown(
                            mq.height * 0.06, mq.width * 0.8),
                  buildCarNumberField(),
                  buildContinueButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCarNameSelectingDropDown(double height, double width) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: _valueCarName,
          items: items,
          onChanged: (value) {
            setState(() {
              _valueCarName = value;
              fetchData(carNames[_valueCarName - 1]);
            });
          },
        ),
      ),
    );
  }

  Widget buildCarModelSelectingDropDown(double height, double width) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: _valueCarModel,
          items: modelDropDown,
          onChanged: (value) {
            setState(() {
              _valueCarModel = value;
            });
          },
        ),
      ),
    );
  }

  Widget buildCarNumberField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      child: TextField(
        textCapitalization: TextCapitalization.characters,
        decoration: const InputDecoration(
          hintText: 'Car Plate Number',
          border: InputBorder.none,
        ),
        controller: _controller,
      ),
    );
  }

  Widget buildContinueButton() {
    var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d2dc);
    _valuePinCode > 0
        ? print(pinCodes[_valuePinCode - 1])
        : print('not selected');
    return NiceButton(
        background: Colors.white,
        radius: 5,
        padding: const EdgeInsets.all(7),
        text: "Continue",
        icon: FontAwesomeIcons.arrowAltCircleRight,
        gradientColors: [secondColor, firstColor],
        onPressed: (address != null && contact != null)
            ? (_valueCarName != 0 && _valueCarModel != 0
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => SelectPlanScreen(
                              carName: carNames[_valueCarName - 1],
                              carModel: carModel[carNames[_valueCarName - 1]]
                                  [_valueCarModel - 1],
                              carNumber: _controller.text,
                              contact: contact,
                              address: address,
                              pinCode: pinCodes[_valuePinCode - 1],
                            )));
                  }
                : () {
                    buildAlertBox('Enter Correct Car Number');
                  })
            : () {
                buildAlertBox(
                    'Upload Address and Contact Details in your Account.');
              });
  }

  Widget buildPinCodeDropDown(double height, double width) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: _valuePinCode,
          items: pinCodesDropDownList,
          onChanged: (value) {
            setState(() {
              _valuePinCode = value;
            });
          },
        ),
      ),
    );
  }

  buildAlertBox(String text) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text('Error'),
              content: Text(text),
              actions: [
                FlatButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}

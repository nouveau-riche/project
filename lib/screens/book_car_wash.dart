import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constant/const.dart';

class BookCarWash extends StatefulWidget {
  @override
  _BookCarWashState createState() => _BookCarWashState();
}

class _BookCarWashState extends State<BookCarWash> {
  int _valueCarName = 0;
  int _valueCarModel = 0;
  TextEditingController _controller = TextEditingController();

  var isLoading = false;

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

  List model = [];

  modelHelper(String name) async {
    final response = await http.get(
        'https://parseapi.back4app.com/classes/Carmodels_Car_Model_List_$name?limit=10000',
        headers: {
          "X-Parse-Application-Id": "2exBnALHw6mPFFY1NgNN3zj9zZGXWDyAU9bY97dn",
          // This is your app's application id
          "X-Parse-REST-API-Key": "LhU0KFvHfptrdxI15wzRGQJSUHztii0wbEH9wBcx"
          // This is your app's REST API key
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List list = map['results'];
      list.forEach((element) {
        if (!model.contains(element['Model'])) model.add(element['Model']);
      });
    }
    print(model);
  }

  fetchData(String name) {
    setState(() {
      isLoading = true;
    });

    modelDropDown = [
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
                  child: Image.asset('assets/images/sticker.jpg'))),
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
                  buildCarNameSelectingDropDown(
                      mq.height * 0.06, mq.width * 0.8),
                  if (_valueCarName != 0)
                    isLoading == true
                        ? CircularProgressIndicator()
                        : buildCarModelSelectingDropDown(
                            mq.height * 0.06, mq.width * 0.8),
                  buildCarNumberField(),
                  const Spacer(),
                  buildContinueButton(mq.width * 0.8),
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
              modelHelper(carNames[_valueCarName - 1]);
              //fetchData(carNames[_valueCarName - 1]);
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
      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      child: TextField(
        textCapitalization: TextCapitalization.characters,
        decoration: const InputDecoration(
          hintText: 'Car Plate Number',
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          ),
        ),
        controller: _controller,
      ),
    );
  }

  Widget buildContinueButton(double width) {
    return SizedBox(
      width: width,
      child: OutlineButton(
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: const Text(
          'Continue',
          style: const TextStyle(
              color: const Color.fromRGBO(92, 202, 250, 1),
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        onPressed: _valueCarName != 0 &&
                _valueCarModel != 0 &&
                _controller.text.length == 10
            ? () {
                Navigator.of(context).pushNamed('/select-plan-screen');
              }
            : () {
                if (_valueCarName == 0 || _valueCarModel == 0)
                  buildAlertBox('Enter all Fields');
                else
                  buildAlertBox('Enter Correct Car Number');
              },
      ),
    );
  }

  buildAlertBox(String text) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(text),
            ));
  }
}

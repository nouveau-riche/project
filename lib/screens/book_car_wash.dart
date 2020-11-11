import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookCarWash extends StatefulWidget {
  @override
  _BookCarWashState createState() => _BookCarWashState();
}

class _BookCarWashState extends State<BookCarWash> {
  int _valueCarName = 0;
  int _valueCarModel = 0;
  TextEditingController _controller = TextEditingController();

  //Future<Map<String, dynamic>>
  List model = [];
  List<DropdownMenuItem> modelDropDown = [
    DropdownMenuItem(
      child: Text(
        'Select Car Model',
        style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black),
      ),
      value: 0,
    ),
  ];
  var isLoading = false;
  int count = 0;

  fetchData(String name) async {
    setState(() {
      isLoading = true;
    });
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

      int i = 1;
      list.forEach((element) {
        if (!model.contains(element['Model'])) model.add(element['Model']);
      });

      model.forEach((element) {
        modelDropDown.add(
          DropdownMenuItem(
            child: Text(
              element,
              style: TextStyle(
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
    } else {
      throw Exception('Failed to fetch data');
    }
  }


  List carNames = [
    'Audi',
    'Chevrolet',
    'Cadillac',
    'Acura',
    'BMW',
    'Chrysler',
    'Ford',
    'Buick',
    'INFINITI',
    'GMC',
    'Honda',
    'Hyundai',
    'Jeep',
    'Genesis',
    'Dodge',
    'Jaguar',
    'Kia',
    'Land',
    'Rover',
    'Lexus',
    'Mercedes - Benz',
    'Mitsubishi',
    'Lincoln',
    'MAZDA',
    'Nissan',
    'MINI',
    'Porsche',
    'Ram',
    'Subaru',
    'Toyota',
    'Volkswagen',
    'Volvo',
    'Alfa',
    'Romeo',
    'FIAT',
    'Freightliner',
    'Maserati',
    'Tesla',
    'Aston',
    'Martin',
    'Bentley',
    'Ferrari',
    'Lamborghini',
    'Lotus',
    'McLaren',
    'Rolls - Royce',
    'smart',
    'Scion',
    'SRT',
    'Suzuki',
    'Fisker',
    'Maybach',
    'Mercury',
    'Saab',
    'HUMMER',
    'Pontiac',
    'Saturn',
    'Isuzu',
    'Panoz',
    'Oldsmobile',
    'Daewoo',
    'Plymouth',
    'Eagle',
    'Geo',
    'Daihatsu'
  ];

  List<DropdownMenuItem> items = [
    DropdownMenuItem(
      child: Text(
        'Select Car',
        style: TextStyle(
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
            style: TextStyle(
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
  }

  @override
  Widget build(BuildContext context) {
    if(!carNameFetched){
      fun();
    }

    print(_valueCarName);
    //print(carNames[_valueCarName]-1);
    //fetchData(carNames[_valueCarName-1]);

    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(92, 202, 250, 1),
        title: Text(
          'Book Car Wash',
        ),
      ),
      body: Column(
        children: [
          buildCarNameSelectingDropDown(mq.height * 0.06, mq.width * 0.8),
          if (_valueCarName != 0)
            isLoading == true
                ? CircularProgressIndicator()
                : buildCarModelSelectingDropDown(
                    mq.height * 0.06, mq.width * 0.8),
          buildCarNumberField(),
          buildContinueButton(mq.width * 0.5),
        ],
      ),
    );
  }

  Widget buildCarNameSelectingDropDown(double height, double width) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: _valueCarName,
          items: items,
          onChanged: (value) {
            setState(() {
              _valueCarName = value;
              if (value >= 0) {
                if (count == 1) {
                  modelDropDown.clear();
                  model.clear();
                }
                fetchData(carNames[_valueCarName - 1]);
                count = 1;
                carNameFetched = true;
              }
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
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
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
        decoration: InputDecoration(
          hintText: 'Car Plate Number',
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        controller: _controller,
      ),
    );
  }

  Widget buildContinueButton(double width) {
    return SizedBox(
      width: width,
      child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color:
              _valueCarName != 0 && _valueCarModel != 0 && _controller != null
                  ? Color.fromRGBO(92, 202, 250, 1)
                  : Colors.grey[200],
          child: Text('Continue'),
          onPressed:
              //_valueCarName != 0 && _valueCarModel != 0 && _controller != null ?
              () {
            Navigator.of(context).pushNamed('/select-plan-screen');
          }
          //  : () {},
          ),
    );
  }
}

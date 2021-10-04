import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui';
import "package:http/http.dart" as http;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameTextController,
      _numberTextController,
      designationTextController,
      cityTextController;
  String name, number, designation, city;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 108, 96, 225),
        title: Text(
          "Your Details",
          style: TextStyle(fontFamily: "Shortbaby"),
        ),
        toolbarHeight: 100,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromARGB(255, 108, 96, 225),
          ),
          getCard(),
        ],
      ),
    );
  }

  Widget getCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height - 50,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: ListView(
              children: <Widget>[
                TextFormField(

                  controller: _nameTextController,
                  decoration: InputDecoration(
                    labelText:"Name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 108, 96, 225),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 108, 96, 225),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Name",
                  ),
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      name = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _numberTextController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText:"Number",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 108, 96, 225),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 108, 96, 225),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Number",
                    ),
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        number = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: designationTextController,
                    decoration: InputDecoration(
                      labelText: "Profession designation",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 108, 96, 225),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 108, 96, 225),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Profession designation",
                    ),
                    onChanged: (value) {
                      setState(() {
                        designation = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: cityTextController,
                    decoration: InputDecoration(
                      labelText: "City you live",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 108, 96, 225),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 108, 96, 225),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "city you live",
                    ),
                    onChanged: (value) {
                      setState(() {
                        city = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Gender",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 108, 96, 225)),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    addRadioButton(0, 'Male'),
                    addRadioButton(1, 'Female'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      var v = "http://localhost:3000/api/user";
                      var body = {
                        "name": name,
                        "number": number,
                        "professionDesignation": designation,
                        "city": city,
                        "gender": select,
                      };
                      var headers = {
                        "content-type": "application/json",
                        "accept": "application/json",
                      };
                      var response = await http.Client().post(
                          Uri.parse(
                              "http://192.168.0.176:3000/api/user/userpoint/points"),
                          body: jsonEncode(body),
                          headers: headers);
                      print(response.body);
                    },
                    child: Text("Save Details"),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List gender = ["Male", "Female"];

  String select;

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,

          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }
}

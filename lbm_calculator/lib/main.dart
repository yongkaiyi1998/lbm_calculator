import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controllerheight = new TextEditingController();
  TextEditingController _controllerweight = new TextEditingController();
  String genderGrp = 'Male';
  String ageGrp = 'No';
  double boer = 0.0;
  double james = 0.0;
  double hume = 0.0;
  double peter = 0.0;
  double boerfat = 0.0;
  double jamesfat = 0.0;
  double humefat = 0.0;
  double peterfat = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.yellow,
        body: Center(
          child: Container(
            height: 450,
            width: 350,
            child: Card(
                elevation: 5,
                color: Colors.white70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lean Body Mass Calculator',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Gender?', style: TextStyle(fontSize: 17)),
                        Radio(
                            value: 'Male',
                            groupValue: genderGrp,
                            onChanged: (val) {
                              genderGrp = val;
                              setState(() {});
                            }),
                        Text('Male'),
                        Radio(
                            value: 'Female',
                            groupValue: genderGrp,
                            onChanged: (val) {
                              genderGrp = val;
                              setState(() {});
                            }),
                        Text('Female'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Age 14 or younger?',
                            style: TextStyle(fontSize: 17)),
                        Radio(
                            value: 'Yes',
                            groupValue: ageGrp,
                            onChanged: (val) {
                              ageGrp = val;
                              setState(() {});
                            }),
                        Text('Yes'),
                        Radio(
                            value: 'No',
                            groupValue: ageGrp,
                            onChanged: (val) {
                              ageGrp = val;
                              setState(() {});
                            }),
                        Text('No'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextField(
                          controller: _controllerheight,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Height(cm)',
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: _controllerweight,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Weight(kg)',
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            calculateLBM(
                                _controllerweight.text, _controllerheight.text);
                          },
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: <Color>[
                              Colors.yellow[900],
                              Colors.yellow[600],
                              Colors.yellow[300]
                            ])),
                            padding: EdgeInsets.only(
                                left: 28, right: 28, top: 10, bottom: 10),
                            child: Text('Calculate'),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _controllerheight.clear();
                            _controllerweight.clear();
                            ageGrp = 'No';
                            genderGrp = 'Male';
                            boer = 0.0;
                            james = 0.0;
                            hume = 0.0;
                            peter = 0.0;
                            boerfat = 0.0;
                            jamesfat = 0.0;
                            humefat = 0.0;
                            peterfat = 0.0;
                            setState(() {});
                          },
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: <Color>[
                              Colors.yellow[900],
                              Colors.yellow[600],
                              Colors.yellow[300]
                            ])),
                            padding: EdgeInsets.only(
                                left: 28, right: 28, top: 10, bottom: 10),
                            child: Text('Clear'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('Boer:' +
                        boer.toStringAsFixed(3) +
                        'KG' +
                        '(' +
                        boerfat.toStringAsFixed(0) +
                        '% Body Fat)'),
                    Text('James:' +
                        james.toStringAsFixed(3) +
                        'KG' +
                        '(' +
                        jamesfat.toStringAsFixed(0) +
                        '% Body Fat)'),
                    Text('Hume:' +
                        hume.toStringAsFixed(3) +
                        'KG' +
                        '(' +
                        humefat.toStringAsFixed(0) +
                        '% Body Fat)'),
                    Text('Peter(Children):' +
                        peter.toStringAsFixed(3) +
                        'KG' +
                        '(' +
                        peterfat.toStringAsFixed(0) +
                        '% Body Fat)'),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  calculateLBM(String weights, String heights) {
    _controllerheight.clear();
    _controllerweight.clear();
    ageGrp = 'No';
    genderGrp = 'Male';
    boer = 0.0;
    james = 0.0;
    hume = 0.0;
    peter = 0.0;
    boerfat = 0.0;
    jamesfat = 0.0;
    humefat = 0.0;
    peterfat = 0.0;
    double weight = double.parse(weights);
    double height = double.parse(heights);
    if (ageGrp == 'No') {
      if (genderGrp == 'Male') {
        boer = 0.407 * weight + 0.267 * height - 19.2;
        james = 1.1 * weight - 128 * pow((weight / height), 2);
        hume = 0.32810 * weight + 0.33929 * height - 29.5336;
      } else {
        boer = 0.252 * weight + 0.473 * height - 48.3;
        james = 1.07 * weight - 148 * pow((weight / height), 2);
        hume = 0.29569 * weight + 0.41813 * height - 43.2933;
      }
    } else {
      peter = 3.8 * (0.0215 * pow(weight, 0.6469) * pow(height, 0.7236));
    }
    boer.toStringAsFixed(3);
    james.toStringAsFixed(3);
    hume.toStringAsFixed(3);
    peter.toStringAsFixed(3);
    if (peter == 0.0) {
      boerfat = (weight - boer) / weight * 100;
      jamesfat = (weight - james) / weight * 100;
      humefat = (weight - hume) / weight * 100;
      boerfat.toStringAsFixed(0);
      jamesfat.toStringAsFixed(0);
      humefat.toStringAsFixed(0);
    } else {
      peterfat = (weight - peter) / weight * 100;
      peterfat.toStringAsFixed(0);
    }
    setState(() {});
  }
}

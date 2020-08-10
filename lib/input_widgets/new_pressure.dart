import 'package:amun/models/BloodPressure.dart';
import 'package:amun/models/Responses/BloodPressureResponse.dart';
import 'package:amun/screens/blood_pressure_screen.dart';
import 'package:amun/screens/success_screen.dart';

import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/material.dart';
import '../services/APIClient.dart';
import '../utils/TokenStorage.dart';
import 'DialogManager.dart';

class NewPressure extends StatefulWidget {
  @override
  _NewPressureState createState() => _NewPressureState();
}

class _NewPressureState extends State<NewPressure> {
  BloodPressure pressure = new BloodPressure(lower: 80, upper: 120);
  final noteController = TextEditingController();
  String _patientToken;

  @override
  void initState() {
    super.initState();
    print("getting user token");
    getUserToken();
  }

  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });
    });
  }

/*------------------------------- */
/*add function */
  void addMeasure() {
    DialogManager.showLoadingDialog(context);
    pressure.note = noteController.text;
    pressure.date = DateTime.now();
   
    APIClient()
        .getBloodPressureService()
        .addBloodPressureMeasure(bloodPressure: pressure, token: _patientToken)
        .then((BloodPressureResponse bloodPressureResponse) {
      if (bloodPressureResponse.success) {
        DialogManager.stopLoadingDialog(context);
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(BloodPressureScreen.routeName);        
      }
    }).catchError((Object e) {
      DialogManager.stopLoadingDialog(context);
      DialogManager.showErrorDialog(context, "Couldn't add measure");
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        'Pressure',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Card(
                            margin: EdgeInsets.all(10),
                            elevation: 4,
                            child: NumberPicker.integer(
                              infiniteLoop: true,
                              itemExtent: 40,
                              decoration: _decoration,
                              listViewWidth: 100,
                              initialValue: pressure.upper,
                              minValue: 100,
                              maxValue: 170,
                              onChanged: (newValue) =>
                                  setState(() => pressure.upper = newValue),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: FittedBox(
                              child: Text(
                                'Upper: ${pressure.upper} mm hg',
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Card(
                            margin: EdgeInsets.all(10),
                            elevation: 4,
                            child: NumberPicker.integer(
                              infiniteLoop: true,
                              itemExtent: 40,
                              decoration: _decoration,
                              listViewWidth: 100,
                              initialValue: pressure.lower,
                              minValue: 40,
                              maxValue: 100,
                              onChanged: (newValue) =>
                                  setState(() => pressure.lower = newValue),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: FittedBox(
                              child: Text(
                                'Lower: ${pressure.lower} mm hg',
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Note",
                    ),
                    controller: noteController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 30),
                  child: FlatButton(
                      onPressed: addMeasure,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Decoration _decoration = new BoxDecoration(
    border: new Border(
      top: new BorderSide(
        style: BorderStyle.solid,
        color: Colors.black26,
      ),
      bottom: new BorderSide(
        style: BorderStyle.solid,
        color: Colors.black26,
      ),
    ),
  );
}

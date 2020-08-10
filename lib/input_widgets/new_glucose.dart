import 'package:amun/screens/glucose_screen.dart';
import 'package:amun/screens/success_screen.dart';
import 'package:flutter/material.dart';

import 'package:amun/input_widgets/DialogManager.dart';
import 'package:amun/models/BloodGlucose.dart';
import 'package:numberpicker/numberpicker.dart';
import '../services/APIClient.dart';
import '../models/Responses/BloodGlucoseResponse.dart';
import '../utils/TokenStorage.dart';

class NewGlucose extends StatefulWidget {
  @override
  _NewGlucoseState createState() => _NewGlucoseState();
}

class _NewGlucoseState extends State<NewGlucose> {
  BloodGlucose glucose = new BloodGlucose();
  final noteController = TextEditingController();
  String _patientToken;

  /* init state for token */
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
      //print(_patientToken);
    });
  }

/*------------------------------- */
/*add function */
  void addMeasure() {
    DialogManager.showLoadingDialog(context);
    glucose.note = noteController.text;
    glucose.value = currentValue;
    glucose.date = DateTime.now();

    APIClient()
        .getBloodGlucoseService()
        .addBloodGlucoseMeasure(glucose, _patientToken)
        .then((BloodGlucoseResponse bloodGlucoseResponse) {
      if (bloodGlucoseResponse.success) {
        DialogManager.stopLoadingDialog(context);
        Navigator.of(context).pop();
        Navigator.of(context)
            .pushReplacementNamed(BloodGlucoseScreen.routeName);
        
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
      body: SingleChildScrollView(
        child: Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Text(
                    'Blood Glucose',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: 4,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Type",
                            style: Theme.of(context).textTheme.title,
                          ),
                          buildRadioListTile(TimeType.fasting, 'Fasting'),
                          buildRadioListTile(
                              TimeType.afterEating, 'After Eating'),
                          buildRadioListTile(
                              TimeType.two_three_hours_aftrer_eating,
                              '2-3 hours after eating'),
                        ],
                      )),
                ),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: buildNumberPicker(
                      title: 'Glucose', measureUnite: 'mg/dl'),
                ),
              ),
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
    );
  }

  Widget buildRadioListTile(
    TimeType intailValue,
    String title,
  ) {
    return Container(
      width: 180,
      child: RadioListTile(
        title: Text(title),
        value: intailValue,
        groupValue: glucose.timeType,
        onChanged: (TimeType value) {
          setState(() {
            glucose.timeType = value;

            if (value == TimeType.fasting) {
              min = 80;
              max = 300;
              currentValue = 81;
            }
            if (value == TimeType.afterEating) {
              min = 170;
              max = 300;
              currentValue = 171;
            }
            if (value == TimeType.two_three_hours_aftrer_eating) {
              min = 120;
              max = 500;
              currentValue = 131;
            }
          });
        },
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

  int min = 1;
  int max = 2;
  int currentValue = 2;

  Widget buildNumberPicker({
    String title,
    String measureUnite,
  }) {
    return Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(10),
          elevation: 4,
          child: NumberPicker.integer(
            infiniteLoop: true,
            itemExtent: 40,
            decoration: _decoration,
            listViewWidth: 100,
            initialValue: currentValue,
            minValue: min,
            maxValue: max,
            onChanged: (newValue) => setState(() {
              currentValue = newValue;
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            '$title: $currentValue $measureUnite',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }
}

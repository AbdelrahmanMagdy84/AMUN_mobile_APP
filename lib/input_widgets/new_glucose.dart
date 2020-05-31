import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import '../input_widgets/custom_number_picker.dart';
import '../models/blood_glucose.dart';
import 'package:flutter/material.dart';

class NewGlucose extends StatefulWidget {
  @override
  _NewGlucoseState createState() => _NewGlucoseState();
}

class _NewGlucoseState extends State<NewGlucose> {
  BloodGlucose glucose = new BloodGlucose();

  void displayDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null)
        return;
      else
        setState(() {
          glucose.date = pickedDate;
        });
    });
  }

  Widget buildRadioListTile(Type intailValue, String title) {
    return Container(
      width: 180,
      child: RadioListTile(
        title: Text(title),
        value: intailValue,
        groupValue: glucose.type,
        onChanged: (Type value) {
          setState(() {
            glucose.type = value;
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

  static int min = 70;
  static int max = 250;
  static int currentValue =140;

  Widget buildNumberPicker({String title, String measureUnite}) {
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
            onChanged: (newValue) => setState(() => currentValue = newValue),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            '$title: $currentValue $measureUnite',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
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
              height: 200,
              child: Card(
                child: buildNumberPicker(title: 'Glucose',measureUnite: 'mg/dl'),
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
                        buildRadioListTile(Type.fasting, 'Fasting'),
                        buildRadioListTile(Type.postprandial, 'Postprandial'),
                        buildRadioListTile(Type.random, 'Random'),
                      ],
                    )),
              ),
            ),
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        glucose.date == null
                            ? 'No date chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(glucose.date)}',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: displayDatePicker,
                      child: Icon(
                        Icons.date_range,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            FlatButton(
                padding: EdgeInsets.all(30),
                onPressed: null,
                color: Theme.of(context).accentColor,
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}

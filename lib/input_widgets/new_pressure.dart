import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import '../input_widgets/custom_number_picker.dart';
import '../models/blood_glucose.dart';
import 'package:flutter/material.dart';

class NewPressure extends StatefulWidget {
  @override
  _NewPressureState createState() => _NewPressureState();
}

class _NewPressureState extends State<NewPressure> {
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

  Widget buildRadioListTile(Type type, String title) {
    return Container(
      width: 180,
      child: RadioListTile<Type>(
        title: Text(title),
        value: type,
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

  Widget buildNumberPicker(
      {String title, String measureUnite, int min, int max, value}) {
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
            initialValue: upper,
            minValue: min,
            maxValue: max,
            onChanged: (newValue) => setState(() => upper = newValue),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            'Upper: $upper $measureUnite',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ],
    );
  }

  int upper = 120;
  int lower = 80;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                            initialValue: upper,
                            minValue: 100,
                            maxValue: 170,
                            onChanged: (newValue) =>
                                setState(() => upper = newValue),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: FittedBox(
                            child: Text(
                              'Upper: $upper mm hg',
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
                            initialValue: lower,
                            minValue: 40,
                            maxValue: 100,
                            onChanged: (newValue) =>
                                setState(() => lower = newValue),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: FittedBox(
                            child: Text(
                              'Lower: $lower mm hg',
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              Container(
                height: 10,
              ),
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
      ),
    );
  }
}

import 'package:amun/input_widgets/new_glucose.dart';
import 'package:amun/input_widgets/new_pressure.dart';
import 'package:amun/items/glucose_item.dart';
import 'package:amun/items/pressure_item.dart';
import 'package:flutter/material.dart';

class BloodGlucoseScreen extends StatefulWidget {
  static final String routeName = "glucose route name";
  @override
  _BloodGlucoseScreenState createState() => _BloodGlucoseScreenState();
}

void startAddNewRecord(BuildContext ctx) {
  showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewGlucose(),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      });
}

class _BloodGlucoseScreenState extends State<BloodGlucoseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blood Glucose",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return GlucoseItem();
        },
        itemCount: 1,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewRecord(context),
        child: Icon(
          Icons.add,
          size: 40,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

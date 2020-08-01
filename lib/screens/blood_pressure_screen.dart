import 'package:amun/input_widgets/new_pressure.dart';
import 'package:amun/items/pressure_item.dart';
import 'package:amun/screens/glucose_screen.dart';
import 'package:flutter/material.dart';

class BloodPressureScreen extends StatefulWidget {
  static final String routeName="pressure route name";
  @override
  _BloodPressureScreenState createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  
 void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewPressure(),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

      

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blood Pressure",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return PressureItem();
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

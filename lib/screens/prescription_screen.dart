import 'package:amun/input_widgets/new_prescription.dart';
import 'package:amun/items/prescription_item.dart';
import 'package:flutter/material.dart';

class PrescriptionScreen extends StatefulWidget {
  static final routeName = 'route name';
  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewPrescriptionOrRadiograph("Prescription"),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prescription")),
      body: Container(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return PrescriptionItemOrRadiograph();
          },
          itemCount: 1,
        ),
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed:()=> startAddNewRecord(context),
        child: Icon(
          Icons.add,
          size: 40,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

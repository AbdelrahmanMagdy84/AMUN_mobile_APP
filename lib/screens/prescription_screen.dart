import 'package:amun/input_widgets/new_medical_record.dart';
import 'package:amun/items/medical_record_item.dart';
import 'package:flutter/material.dart';

class PrescriptionScreen extends StatefulWidget {
  static final routeName = 'Prescription route name';
  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prescription")),
      body: Container(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MedicalRecordItem();
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
  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewMedicalRecord("New Prescription"),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }
}

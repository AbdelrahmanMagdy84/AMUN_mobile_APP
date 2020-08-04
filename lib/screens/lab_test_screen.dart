import 'package:amun/input_widgets/new_prescription.dart';
import 'package:amun/items/medical_record_item.dart';
import 'package:flutter/material.dart';

class LabTestScreen extends StatefulWidget {
  static final routeName = 'labTest route name';
  @override
  _LabTestScreenState createState() => _LabTestScreenState();
}

class _LabTestScreenState extends State<LabTestScreen> {
  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewPrescriptionOrRadiograph("New Lab Test"),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lab Test")),
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
}

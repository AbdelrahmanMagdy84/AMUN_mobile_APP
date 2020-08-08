import 'package:amun/input_widgets/new_medical_record.dart';
import 'package:amun/items/medical_record_item.dart';
import 'package:flutter/material.dart';

class RadiographScreen extends StatefulWidget {
  static final routeName = 'radiograph route name';
  @override
  _RadiographScreenState createState() => _RadiographScreenState();
}

class _RadiographScreenState extends State<RadiographScreen> {
  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewMedicalRecord("Radiograph"),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Radiograph")),
      body: Container(
        // child: ListView.builder(
        //   itemBuilder: (ctx, index) {
        //     return MedicalRecordItem();
        //   },
        //   itemCount: 1,
        // ),
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

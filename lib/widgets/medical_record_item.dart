import 'package:flutter/material.dart';
class MedicalRecordlItem extends StatelessWidget {
  String title;
  MedicalRecordlItem(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Text(title),
    );
  }
}
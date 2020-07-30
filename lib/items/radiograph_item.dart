import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class RadiographItem extends StatefulWidget {
  String title = 'systolic';
  RadiographItem(this.title);
  @override
  _RadiographItemState createState() => _RadiographItemState();
}

class _RadiographItemState extends State<RadiographItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset(
      'images/pres.png',
      fit: BoxFit.fitWidth,
      height: double.infinity,
      width: double.infinity,
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomNumberPicker extends StatefulWidget {
  
  String title ;
  String measurementUnit;
  int highestHundreds;
  int lowestTens;
  CustomNumberPicker({this.title,this.measurementUnit='',this.highestHundreds,this.lowestTens});
  @override
  
  
  _CustomNumberPickerState createState() => _CustomNumberPickerState();
}



class _CustomNumberPickerState extends State<CustomNumberPicker> {
    Widget buildNumberPicker(int min, int max) {
     int currentValue=((max+min)/2) as int;
    return NumberPicker.integer(
        initialValue: currentValue,
        minValue: min,
        maxValue: max,
        onChanged: (newValue) => setState(() => currentValue = newValue));
  }

  int units = 5;
  int tens = 5;
  int hundreds = 1;
  int total = 155;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Card(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(10),
            elevation: 4,
           // child: buildNumberPicker(min, max),
              // // child: Row(
              // //   mainAxisAlignment: MainAxisAlignment.center,
              // //   children: <Widget>[
              // //    
              // //     // NumberPicker.integer(
              // //     //     infiniteLoop: true,
              // //     //     listViewWidth: 40,
              // //     //     itemExtent: 40,
              // //     //     decoration: _decoration,
              // //     //     initialValue: hundreds,
              // //     //     minValue: 0,
              // //     //     maxValue: widget.highestHundreds,
              // //     //     onChanged: (newValue) =>
              // //     //         setState(() => hundreds = newValue)),
              // //     // NumberPicker.integer(
              // //     //     infiniteLoop: true,
              // //     //     listViewWidth: 40,
              // //     //     itemExtent: 40,
              // //     //     decoration: _decoration,
              // //     //     initialValue: tens,
              // //     //     minValue: widget.lowestTens,
              // //     //     maxValue: 9,
              // //     //     onChanged: (newValue) => setState(() => tens = newValue)),
              // //     // NumberPicker.integer(
              // //     //     itemExtent: 40,
              // //     //     infiniteLoop: true,
              // //     //     listViewWidth: 40,
              // //     //     decoration: _decoration,
              // //     //     initialValue: units,
              // //     //     minValue: 0,
              // //     //     maxValue: 9,
              // //     //     onChanged: (newValue) => setState(() => units = newValue)),
              // //   ],
              // // ),
            ),
            Text(
              "${widget.title}: ${total = (hundreds * 100 + tens * 10 + units)} ${widget.measurementUnit}",
              style: Theme.of(context).textTheme.title,
            ),
          ],
        ),
      ),
    );
  }
}

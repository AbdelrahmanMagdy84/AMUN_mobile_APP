import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/blood_Pressure.dart';

class PressureItem extends StatelessWidget {
  DateTime date = DateTime.now();
  int upper = 255;
  int lower = 177;
  //int heartRate = 80;
  Widget buildCircleAvatar(int value,BuildContext ctx){
    return CircleAvatar(
            backgroundColor: Theme.of(ctx).accentColor,
            child: Padding(
              padding: EdgeInsets.all(7),
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '$value',
                        style: TextStyle(
                            color: Theme.of(ctx).primaryColor, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Text(
                          'mm Hg',
                          style: TextStyle(
                              color: Theme.of(ctx).primaryColor, fontSize: 12),
                        ),
                      )
                    ],
                  )),
            ),
            radius: 30,
          );
  }

  Widget buildColumn(BuildContext ctx, int number, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          buildCircleAvatar(number, ctx),
          Divider(
            height: 6,
          ),
          Text(
            title,
            style: TextStyle(color: Theme.of(ctx).accentColor, fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget buildListTile(BuildContext ctx, int upper, int lower,
      DateTime date) {
    return Row(children: <Widget>[
     
      Expanded(child: buildColumn(ctx, upper, 'Upper')),
      Expanded(child: buildColumn(ctx, lower, 'Lower')),
      //  buildColumn(ctx, heartRate, 'heartRate'),
       Padding(
        padding: const EdgeInsets.all(10),
        child: Text(DateFormat.yMMMd().format(date)),
      ),
      IconButton(
          padding: EdgeInsets.only(left: 10),
          icon: Icon(
            Icons.delete,
            color: Theme.of(ctx).errorColor,
          ),
          onPressed: () {}
          // widget.delete(widget.transaction.id),
          ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: buildListTile(context, upper, lower,  date),
    );
  }
}

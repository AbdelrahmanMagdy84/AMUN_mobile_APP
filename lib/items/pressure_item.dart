import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/blood_Pressure.dart';

class PressureItem extends StatelessWidget {
  DateTime date = DateTime.now();
  int upper = 180;
  int lower = 80;
  //int heartRate = 80;
  Widget buildCircleAvatar(int value, BuildContext ctx) {
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

  Map<String, Object> getPressureIndecator(int upper, int lower) {
    if (upper <= 120 && lower <= 80) {
      return {'indecator': 'Normal', 'color': Colors.blue[100]};
    } else if ((121 <= upper && upper <= 129) && lower <= 80) {
      return {'indecator': 'Elevated', 'color': Colors.deepOrangeAccent[100]};
    } else if ((130 <= upper && upper <= 139) || (80 < lower && lower <= 89)) {
      return {
        'indecator': "High blood pressure satge 1",
        'color': Colors.orange
      };
    } else if ((140 <= upper && upper <= 179) || (90 < lower && lower <= 119)) {
      return {
        'indecator': "High blood pressure satge 2",
        'color': Colors.deepOrangeAccent[700]
      };
    } else if ((180 <= upper) || (120 < lower)) {
      return {'indecator': "Hypertensive crisis", 'color': Colors.red[400]};
    }
  }

  Widget buildPressureItem(
      BuildContext ctx, int upper, int lower, DateTime date) {
    Map<String, Object> obj = getPressureIndecator(upper, lower);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: obj['color'],
            child: Center(
              child: Text(
                obj['indecator'],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(children: <Widget>[
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
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // hna hn3ml return lee list mn pressure item (buildPressureItem)
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: buildPressureItem(context, upper, lower, date),
    );
  }
}
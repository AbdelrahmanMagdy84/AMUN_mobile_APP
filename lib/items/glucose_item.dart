import '../models/BloodGlucose.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlucoseItem extends StatefulWidget {
  final BloodGlucose glucoseObj;
  GlucoseItem(this.glucoseObj);
  @override
  _GlucoseItemState createState() => _GlucoseItemState();
}

class _GlucoseItemState extends State<GlucoseItem> {
  DateTime date = DateTime.now();
  String note =
      "Resources are limited to 1000 pounds of special plastic 40 hours of production time per week Resources are limited to 1000 pounds of special plastic 40 hours of production time per week ";

  @override
  Widget build(BuildContext context) {
    BloodGlucose bloodGlucose = widget.glucoseObj;
      
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: buildListTile(context, bloodGlucose),
    );
  }

  Widget buildListTile(BuildContext ctx, BloodGlucose bloodGlucose) {
    Map<String, Object> obj = getGlucoseIndecator(bloodGlucose);
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                CircleAvatar(
                  backgroundColor: Theme.of(ctx).accentColor,
                  child: Padding(
                    padding: EdgeInsets.all(7),
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${bloodGlucose.value}',
                              style: TextStyle(
                                  color: Theme.of(ctx).primaryColor,
                                  fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                'mg/dl',
                                style: TextStyle(
                                    color: Theme.of(ctx).primaryColor,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        )),
                  ),
                  radius: 30,
                ),
              ]),
            ),
            Expanded(
              child: Text(
                getTimeTypeText(bloodGlucose.timeType),
                style: TextStyle(
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: <Widget>[
                  Text(DateFormat.Hm().format(bloodGlucose.date)),
                  Text(DateFormat.yMMMd().format(bloodGlucose.date)),
                ],
              ),
            ),
            IconButton(
                padding: EdgeInsets.only(left: 10, right: 10),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(ctx).errorColor,
                ),
                onPressed: () {}
                // widget.delete(widget.transaction.id),
                ),
          ]),
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Text(
              "Note: ${bloodGlucose.note}",
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, Object> getGlucoseIndecator(BloodGlucose bloodGlocose) {
    if (bloodGlocose.timeType == TimeType.fasting) {
      if (80 <= bloodGlocose.value && bloodGlocose.value <= 100) {
        return {'indecator': 'Normal', 'color': Colors.green};
      } else if (101 <= bloodGlocose.value && bloodGlocose.value <= 125) {
        return {'indecator': 'Pre-diabetic', 'color': Colors.yellow};
      } else if (126 <= bloodGlocose.value) {
        return {'indecator': "Diabetic", 'color': Colors.red};
      }
    } else if (bloodGlocose.timeType == TimeType.afterEating) {
      if (170 <= bloodGlocose.value && bloodGlocose.value <= 200) {
        return {'indecator': 'Normal', 'color': Colors.green};
      } else if (190 <= bloodGlocose.value && bloodGlocose.value <= 230) {
        return {'indecator': 'Pre-diabetic', 'color': Colors.yellow};
      } else if (231 <= bloodGlocose.value && bloodGlocose.value <= 300) {
        return {'indecator': "Diabetic", 'color': Colors.red};
      }
    } else if (bloodGlocose.timeType ==
        TimeType.two_three_hours_aftrer_eating) {
      if (120 <= bloodGlocose.value && bloodGlocose.value <= 140) {
        return {'indecator': 'Normal', 'color': Colors.green};
      } else if (141 <= bloodGlocose.value && bloodGlocose.value <= 199) {
        return {'indecator': 'Pre-diabetic', 'color': Colors.yellow};
      } else if (200 <= bloodGlocose.value) {
        return {'indecator': "Diabetic", 'color': Colors.red};
      }
    }
    return null;
  }

  String getTimeTypeText(TimeType timeType) {
    switch (timeType) {
      case TimeType.fasting:
        return 'Fasting';

      case TimeType.afterEating:
        return 'After Eating';

      case TimeType.two_three_hours_aftrer_eating:
        return '2-3 Hours After Eating';
    }
    return '';
  }
}

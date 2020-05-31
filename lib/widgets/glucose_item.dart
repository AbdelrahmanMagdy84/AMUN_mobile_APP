import '../models/blood_glucose.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlucoseItem extends StatelessWidget {
   DateTime date = DateTime.now();
  final int glucose = 125;
  final String type = 'Fasting';
  BloodGlucose bloodGlocose = BloodGlucose(date: DateTime.now(),value: 125,timeType: TimeType.fasting);



  Map<String, Object> getGlucoseIndecator(BloodGlucose bloodGlocose) {
    if (bloodGlocose.timeType==TimeType.fasting ) {
    if (80<=bloodGlocose.value &&bloodGlocose.value<=100) {
      return {'indecator': 'Normal', 'color': Colors.green};
    } else if (101<=bloodGlocose.value &&bloodGlocose.value<=125) {
      return {'indecator': 'Impaired Glucose', 'color': Colors.yellow};
    } else if (126<=bloodGlocose.value ) {
      return {
        'indecator': "Diabetic",
        'color': Colors.red
      };
      }};
   
  }
  Widget buildListTile(
      BuildContext ctx, BloodGlucose bloodGlucose) {
         Map<String, Object> obj = getGlucoseIndecator(bloodGlucose);
    return Container(
      color: obj['color'],
      child: Column(
        children: <Widget>[
          Container(child: Center(child: Text(obj['indecator']),),),
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
                              '$glucose',
                              style: TextStyle(
                                  color: Theme.of(ctx).primaryColor, fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                'mg/dl',
                                style: TextStyle(
                                    color: Theme.of(ctx).primaryColor, fontSize: 12),
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
                type,
                style: Theme.of(ctx).textTheme.title,
              ),
              flex: 1,
            ),
            Text(DateFormat.yMMMd().format(date)),
            IconButton(
                padding: EdgeInsets.only(left: 30, right: 20),
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
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: buildListTile(context,bloodGlocose),
      
    );
  }
}

import 'package:amun/input_widgets/new_glucose.dart';
import 'package:amun/items/glucose_item.dart';
import 'package:amun/models/BloodGlucose.dart';
import 'package:amun/models/Responses/BloodGlucoseResponseList.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';

class BloodGlucoseScreen extends StatefulWidget {
  static final String routeName = "glucose route name";
  @override
  _BloodGlucoseScreenState createState() => _BloodGlucoseScreenState();
}

class _BloodGlucoseScreenState extends State<BloodGlucoseScreen> {
  List<BloodGlucose> glucoseList;
  Future userFuture;
  @override
  void initState() {
    super.initState();
    print("getting user token");
    getUserToken();
  }

  String _patientToken;
  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });
      
      userFuture = APIClient()
          .getBloodGlucoseService()
          .getBloodGlucoseMeasure(_patientToken)
          .then((BloodGlucoseResponseList responseList) {
        if (responseList.success) {
          glucoseList = responseList.bloodGlucose;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blood Glucose",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: userFuture,
          builder: (ctx, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("none");
                break;
              case ConnectionState.active:
              case ConnectionState.waiting:
              print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
              print(snapshot.data);
              print(glucoseList);
                return Center(
                    child: Text(
                  "Loading ",
                  style: Theme.of(context).textTheme.title,
                ));
                break;
              case ConnectionState.done:
                if (glucoseList == null) {
                  return Center(
                    child: Text("Empty Press + to add"),
                  );
                } else {
                   glucoseList=glucoseList.reversed.toList();
                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      return GlucoseItem(glucoseList[index]);
                    },
                    itemCount: glucoseList.length,
                  );
                }
                break;
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewRecord(context),
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
            child: NewGlucose(),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }
}
/*------------------------------- */
/*add function */
// void getGlucoseList() {
//   // DialogManager.showLoadingDialog(context);
//   APIClient()
//       .getBloodGlucoseService()
//       .getBloodGlucoseMeasure(_patientToken)
//       .then((BloodGlucoseResponseList responseList) {
//     if (responseList.success) {
//       //  DialogManager.stopLoadingDialog(context);
//       glucoseList = responseList.bloodGlucose;
//       print("---------------------------");
//       print(responseList.bloodGlucose.length);
//       print("---------------------------");
//     }
//   }).catchError((Object e) {
//     print("---------------------------x");
//     DialogManager.stopLoadingDialog(context);
//     DialogManager.showErrorDialog(context, "Couldn't get measures");
//     print(e.toString());
//   });
// }

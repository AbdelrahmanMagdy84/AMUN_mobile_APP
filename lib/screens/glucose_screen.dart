import 'package:amun/input_widgets/DialogManager.dart';
import 'package:amun/input_widgets/new_glucose.dart';

import 'package:amun/items/glucose_item.dart';
import 'package:amun/models/BloodGlucose.dart';
import 'package:amun/models/Responses/BloodGlucoseResponse.dart';
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
  String _patientToken;
  List<BloodGlucose> glucoseList;

  /* init state for token */
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
     getUserToken();
    super.didChangeDependencies();
    
  }
  // @override
  // void initState() {
  //   super.initState();
  //   print("getting user token");
   
  // }

  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });
      getGlucoseList();
     
    });
  }

/*------------------------------- */
/*add function */
  void getGlucoseList() {
   // DialogManager.showLoadingDialog(context);
    APIClient()
        .getBloodGlucoseService()
        .getBloodGlucoseMeasure(_patientToken)
        .then((BloodGlucoseResponseList responseList) {
            
      if (responseList.success) {
     //  DialogManager.stopLoadingDialog(context);
        glucoseList = responseList.bloodGlucose;
        print("---------------------------");
        print(responseList.bloodGlucose.length);
        print("---------------------------");
      }
    }).catchError((Object e) {
        print("---------------------------x");
      DialogManager.stopLoadingDialog(context);
      DialogManager.showErrorDialog(context, "Couldn't get measures");
      print(e.toString());
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
      body: glucoseList == null
          ? Center(child: Text('no data to show !'))
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return GlucoseItem(glucoseList[index]);
              },
              itemCount: glucoseList.length,
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

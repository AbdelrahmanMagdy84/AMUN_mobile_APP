import 'package:amun/input_widgets/new_medical_record.dart';
import 'package:amun/items/medical_record_item.dart';
import 'package:amun/models/MedicalRecord.dart';
import 'package:amun/models/Responses/MedicalRecordsResponse.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';

class LabTestScreen extends StatefulWidget {
  static final routeName = 'labTest route name';
  @override
  _LabTestScreenState createState() => _LabTestScreenState();
}

class _LabTestScreenState extends State<LabTestScreen> {
  Future userFuture;
  List<MedicalRecord> medicalRecords;
  List<MedicalRecord> orginList;

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
          .getMedicalRecordService()
          .getMedicalRecords(_patientToken, "labTest")
          .then((MedicalRecordsResponse responseList) {
        if (responseList.success) {
          orginList = responseList.medicalRecord;
          medicalRecords = orginList.reversed.toList();
        }
      });
    });
  }

  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewMedicalRecord("Lab Test"),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void clickHandle(value) {
    if (value == "Recent") {
      setState(() {
        medicalRecords = orginList.reversed.toList();
      });
    } else if (value == "History") {
      setState(() {
        medicalRecords=orginList;
        medicalRecords.sort((a, b) => a.date.compareTo(b.date));
      });
    } else if (value == "entered by patient") {
      print("---------------------------------");
      setState(() {
        medicalRecords=orginList;
        medicalRecords = medicalRecords
            .where((element) => element.enteredBy == "PATIENT")
            .toList();
        print(medicalRecords.length);
      });
    } else if (value == "entered by clerk") {
      setState(() {
        medicalRecords=orginList;
        medicalRecords = medicalRecords
            .where((element) => element.enteredBy != "PATIENT")
            .toList();
        print(medicalRecords.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "Recent",
      "History",
      "entered by me",
      "entered by clerk"
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab Test"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: clickHandle,
            itemBuilder: (BuildContext context) {
              return list.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
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
                return Center(
                    child: Text(
                  "Loading ",
                  style: Theme.of(context).textTheme.title,
                ));
                break;
              case ConnectionState.done:
                if (medicalRecords == null) {
                  return Center(
                    child: Text("Empty Press + to add"),
                  );
                } else {
                
                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      return MedicalRecordItem(medicalRecords[index]);
                    },
                    itemCount: medicalRecords.length,
                  );
                }
                break;
            }
          },
        ),
        // child: ListView.builder(
        //   itemBuilder: (ctx, index) {
        //     return MedicalRecordItem();
        //   },
        //   itemCount: 1,
        // ),
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
}

import 'package:amun/input_widgets/new_medical_record.dart';
import 'package:amun/items/medical_record_item.dart';
import 'package:amun/models/MedicalRecord.dart';
import 'package:amun/models/Responses/MedicalRecordsResponse.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';

class PrescriptionScreen extends StatefulWidget {
  static final routeName = 'Prescription route name';
  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
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
          .getMedicalRecords(_patientToken, "Prescription")
          .then((MedicalRecordsResponse responseList) {
        if (responseList.success) {
          orginList = responseList.medicalRecord;
          medicalRecords = List.from(orginList.reversed.toList());
          print(medicalRecords);
        }
      });
    });
  }

  void clickHandle(value) {
    List<MedicalRecord> copyList = List.from(orginList);
    if (value == "Recent") {
      setState(() {
        medicalRecords = copyList.reversed.toList();
      });
    } else if (value == "History") {
      setState(() {
        medicalRecords = copyList.toList();
        medicalRecords.sort((a, b) => a.date.compareTo(b.date));
      });
    } else if (value == "entered by patient") {
      print("---------------------------------");
      setState(() {
        medicalRecords = copyList
            .where((element) => element.enteredBy == "PATIENT")
            .toList();
        print(medicalRecords.length);
      });
    } else if (value == "entered by clerk") {
      setState(() {
        medicalRecords = copyList.reversed.toList();
        medicalRecords = copyList
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
      "entered by patient",
      "entered by clerk"
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Prescription"),
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
            child: NewMedicalRecord("Prescription"),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }
}

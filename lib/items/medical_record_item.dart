import 'dart:io';
import 'dart:typed_data';
import 'package:amun/input_widgets/DialogManager.dart';
import 'package:amun/models/MedicalRecord.dart';

import 'package:amun/screens/lab_test_screen.dart';
import 'package:amun/screens/prescription_screen.dart';
import 'package:amun/screens/radiograph_screen.dart';
import 'package:amun/screens/show_image_screen.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:mime/mime.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicalRecordItem extends StatefulWidget {
  final MedicalRecord medicalRecord;
  MedicalRecordItem(this.medicalRecord);
  @override
  _MedicalRecordItemState createState() => _MedicalRecordItemState();
}

class _MedicalRecordItemState extends State<MedicalRecordItem> {
  String text = '';
  String subject = '';
  String _patientToken;
  @override
  void initState() {
    super.initState();
    print("getting user token");
    getUserToken();
  }

  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });
    });
  }

  void deleteMedicalRecord(MedicalRecord deleteThisRecord) {
    getUserToken();
    DialogManager.showLoadingDialog(context);
    String route;
    DialogManager.showLoadingDialog(context);
    if (deleteThisRecord.type == "Prescription") {
      route = PrescriptionScreen.routeName;
    } else if (deleteThisRecord.type == "Radiograph") {
      route = RadiographScreen.routeName;
    } else {
      route = LabTestScreen.routeName;
    }

    APIClient()
        .getMedicalRecordService()
        .deleteMedicalRecord(deleteThisRecord.id, _patientToken)
        .then((dynamic medicalRecordResponse) {
      if (medicalRecordResponse.success) {
        DialogManager.stopLoadingDialog(context);
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(route);
      }
    }).catchError((Object e) {
      DialogManager.showErrorDialog(context, "Couldn't delete Medical record");
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final MedicalRecord newMedicalRecord = widget.medicalRecord;
    String facility;
    String doctor;
    String clerk;
    String image;
    String enteredBy;
    String fileName;
    if (newMedicalRecord.enteredBy == "PATIENT") {
      enteredBy = "me";
    } else if (newMedicalRecord.enteredBy == "CLERK") {
      enteredBy = "Clerk";
      facility = newMedicalRecord.medicalFacility.name;
      doctor =
          "${newMedicalRecord.doctor.firstName} ${newMedicalRecord.doctor.lastName}";
      clerk =
          "${newMedicalRecord.clerk.firstName} ${newMedicalRecord.clerk.lastName}";
    }
    if (newMedicalRecord.type == "Radiograph") {
      image = newMedicalRecord.radiograph.url;
      fileName = newMedicalRecord.radiograph.fileName;
    } else if (newMedicalRecord.type == "Prescription") {
      image = newMedicalRecord.prescription.url;
      fileName = newMedicalRecord.prescription.fileName;
    } else {
      image = newMedicalRecord.report.url;
      fileName = newMedicalRecord.report.fileName;
    }

    String title = newMedicalRecord.title;
    String note = newMedicalRecord.note;
    DateTime date = newMedicalRecord.date;

    return Container(
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: FittedBox(
                      child: Text(
                "Title: $title",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ))),
              Divider(),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(1),
                child: Text("Entered By: $enteredBy"),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              if (newMedicalRecord.enteredBy == "PATIENT")
                Container()
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      child: Text("Facility: $facility"),
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              newMedicalRecord.enteredBy == "PATIENT"
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(child: Text("Doctor: DR.$doctor")),
                        Divider(
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
              if (newMedicalRecord.enteredBy == "PATIENT")
                Container()
              else
                Column(
                  children: [
                    FittedBox(child: Text("Clerk: $clerk")),
                    Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (getFileType(fileName) != 'image') {
                        _launchURL(image);
                      } else {
                        Navigator.of(context).pushNamed(
                            ShowImageScreen.routeName,
                            arguments: {'image': image});
                      }
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: getFileType(fileName) != 'image'
                            ? Image.asset(
                                'assets/images/file.png',
                                fit: BoxFit.fitWidth,
                                height: 100,
                                width: 80,
                              )
                            : Image.network(
                                image,
                                fit: BoxFit.fitWidth,
                                height: 100,
                                width: 80,
                              )),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 230,
                    child: Text(
                      "Note: $note",
                      maxLines: 10,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Builder(builder: (BuildContext context) {
                      return IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: image.isEmpty
                              ? null
                              : () async {
                                  var request = await HttpClient()
                                      .getUrl(Uri.parse(image)); //image url
                                  var response = await request.close();
                                  Uint8List bytes =
                                      await consolidateHttpClientResponseBytes(
                                          response);
                                  await Share.file(
                                      '$title', 'amlog.jpg', bytes, 'image/jpg',
                                      text:
                                          " Title: $title\n Doctor: $doctor\n Clerk: $clerk\n Note: $note\n");
                                }
                          // widget.delete(widget.transaction.id),
                          );
                    }),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text(DateFormat.Hm().format(date)),
                        Text(DateFormat.yMMMd().format(date)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () =>
                            deleteMedicalRecord(widget.medicalRecord)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String getFileType(String input) {
    String mimeStr = lookupMimeType(input);
    var fileType = mimeStr.split('/');
    return fileType[0];
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

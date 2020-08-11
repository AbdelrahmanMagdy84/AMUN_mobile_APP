import 'dart:io';
import 'package:amun/models/MedicalRecord.dart';
import 'package:amun/models/Responses/MedicalRecordResponse.dart';
import 'package:amun/screens/lab_test_screen.dart';
import 'package:amun/screens/prescription_screen.dart';
import 'package:amun/screens/radiograph_screen.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'DialogManager.dart';

class NewMedicalRecord extends StatefulWidget {
  final String screenTitle;
  NewMedicalRecord(this.screenTitle);

  @override
  _NewPrescreptionOrRadiographState createState() =>
      _NewPrescreptionOrRadiographState();
}

class _NewPrescreptionOrRadiographState extends State<NewMedicalRecord> {
  DateTime dateTime = DateTime.now();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  DateTime date;

  File file;
/* init state for token */
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
      //print(_patientToken);
    });
  }

  void addMedicalRecord(String type) {
    String field;
    String route;
    DialogManager.showLoadingDialog(context);
    if (type == "Prescription") {
      route = PrescriptionScreen.routeName;
      field = "prescriptionImage";
    } else if (type == "Radiograph") {
      route = RadiographScreen.routeName;
      field = "radiograph";
    } else {
      route = LabTestScreen.routeName;
      field = "report";
    }
    print(titleController.text);
    print(noteController.text);
    print(date);
    print(file.path);

    MedicalRecord medicalRecord = MedicalRecord(
        title: titleController.text,
        note: noteController.text,
        date: date,
        filePath: file.path,
        type: type,
        enteredBy: "PATIENT");

    APIClient()
        .getMedicalRecordService()
        .addMedicalRecords(medicalRecord, _patientToken, field)
        .then((MedicalRecordResponse medicalRecordResponse) {
      if (medicalRecordResponse.success) {
        DialogManager.stopLoadingDialog(context);
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(route);
        // Navigator.of(context).pushNamed(SuccessScreen.routeName);
      }
    }).catchError((Object e) {
      DialogManager.showErrorDialog(context, "Couldn't add measure");
      print(e.toString());
    });
  }

  void save() {
    switch (widget.screenTitle) {
      case "Prescription":
        addMedicalRecord("Prescription");
        break;
      case "Radiograph":
        addMedicalRecord("Radiograph");
        break;
      case "Lab Test":
        addMedicalRecord("labTest");
        break;
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          autovalidate: _autoValidate,
          key: _formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text(
                      "Add New ${widget.screenTitle}",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Divider(),
                buildTextField(
                    'Title', titleController, TextInputType.text, 40),
                buildTextField('Note', noteController, TextInputType.text, 130),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          date == null
                              ? 'No date chosen'
                              : 'Picked Date: ${DateFormat.yMd().format(date)}',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Expanded(
                        child: FloatingActionButton(
                          onPressed: displayDatePicker,
                          child: Icon(
                            Icons.date_range,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.image,
                            color: Theme.of(context).primaryColor),
                        onPressed: () => _openGallery(context),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.attach_file,
                            color: Theme.of(context).primaryColor),
                        onPressed: () => _openFiles(context),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () => _openCamera(context),
                      ),
                    ),
                  ],
                ),
                setImageView(),
                Container(
                  margin: EdgeInsets.all(30),
                  child: FlatButton(
                    onPressed: save,
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String title, TextEditingController controller,
      TextInputType textInputType, int length) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: TextField(
        decoration: InputDecoration(
          labelText: "$title:",
        ),
        controller: controller,
        keyboardType: textInputType,
        maxLength: length,
      ),
    );
  }

  void _openFiles(BuildContext context) async {
    var path = await FilePicker.getFile();
    this.setState(() {
      file = path;
    });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      file = picture;
    });
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      file = picture;
    });
  }

  Widget setImageView() {
    if (file != null) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        margin: EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Image.file(
            file,
            width: double.infinity,
            height: 200,
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      return Container(
        child: Text("Please select an image"),
        padding: EdgeInsets.only(top: 15, bottom: 10),
      );
    }
  }

  void displayDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null)
        return;
      else
        setState(() {
          date = pickedDate;
        });
    });
  }
}

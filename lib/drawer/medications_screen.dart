import 'package:amun/input_widgets/DialogManager.dart';
import 'package:amun/models/Responses/PatientResponse.dart';
import 'package:amun/screens/categories_screen.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'main_drawer.dart';

class MedicationsScreen extends StatefulWidget {
  static final routeName = 'Medication route';

  @override
  _MedicationsScreenState createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  List<String> medications;
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    setState(() {
      if (routeArgs != null) {
        medications = routeArgs['medications'];
      }
    });

    print("getting user token");
    getUserToken();
    super.didChangeDependencies();
  }

  String _patientToken;
  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });
    });
  }

  void updatePatient(List<String> newConditions) {
    DialogManager.showLoadingDialog(context);
    APIClient()
        .getPatientService()
        .updatePatientList(newConditions, "medications", _patientToken)
        .then((PatientResponse patientResponse) {
      if (patientResponse.success) {
        DialogManager.stopLoadingDialog(context);
      }
    }).catchError((Object e) {
      DialogManager.stopLoadingDialog(context);
      DialogManager.showErrorDialog(context, "Couldn't Edit");
      print(e.toString());
    });
  }

  void saveNewMedication(String inputMedication, String dosage) {
    if (_formKey.currentState.validate()) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        if (dosage.length < 4) {
          if (dosage.length == 0) {
            dosage="0000";
          } else if (dosage.length == 1) {
            dosage="000$dosage";
          } else if (dosage.length == 2) {
            dosage="00$dosage";
          } else if (dosage.length == 3) {
            dosage="0$dosage";
          } 
        }
        inputMedication="$inputMedication$dosage";
        List<String> newMedications = medications;
        newMedications.add(inputMedication);
        updatePatient(newMedications);
        Navigator.pushNamedAndRemoveUntil(
            context, CategoriesScreen.routeName, (r) => false);
        Navigator.pushNamed(context, MedicationsScreen.routeName,
            arguments: {'medications': newMedications});
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> reversedList = medications.reversed.toList();
    print(medications);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Medications'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: medications == []
            ? Center(
                child: Text("Empty press + to add"),
              )
            : GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.001,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
                children: List.generate(reversedList.length, (index) {
                  return buildItem(reversedList[index]);
                })),
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

  Widget buildItem(String medication) {
    return Card(
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                //  borderRadius: BorderRadius.circular(40),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 0),
                child: Container(
                  width: constraints.maxWidth * 0.8,
                  //    padding: EdgeInsets.only(top: 5, left: 5),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        width: double.infinity,
                        color: Colors.amber,
                        alignment: Alignment.center,
                        child: Text(
                          'Medication: ',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(height: 100,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '${medication.substring(0,medication.length-4)}',
                              maxLines: 5,
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          //  padding: EdgeInsets.all(5),
                            child: Text(
                              'Dosage: ${medication.substring(medication.length-4,medication.length)} mg',
                              
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  final medicaionController = TextEditingController();
  final dosageController = TextEditingController();
  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Medication",
                          ),
                          controller: medicaionController,
                          keyboardType: TextInputType.text,
                          maxLength: 60,
                          textAlign: TextAlign.center,
                          validator: (String arg) {
                            if (arg.length < 4)
                              return 'condition must be more than 4 charater';
                            else
                              return null;
                          },
                        ),
                        Center(
                          child: Container(
                            width: 100,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Dosage",
                              ),
                              controller: dosageController,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(30),
                          child: FlatButton(
                            onPressed: () =>
                                saveNewMedication(medicaionController.text,dosageController.text),
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
            ),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }
}


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

  void saveNewMedication(String inputMedication) {
    List<String> newMedications = medications;
    newMedications.add(inputMedication);
    updatePatient(newMedications);

    Navigator.pushNamedAndRemoveUntil(
        context, CategoriesScreen.routeName, (r) => false);
    Navigator.pushNamed(context, MedicationsScreen.routeName,
        arguments: {'medications': newMedications});
  }


  @override
  Widget build(BuildContext context) {
   print(medications);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Medications'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: medications == null
            ? Center(
                child: Text("No Medications Add"),
              )
            : GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.05,
                children: List.generate(medications.length, (index) {
                  return buildItem(medications[index]);
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
    return Container(
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(.2),
                    Theme.of(context).primaryColor
                  ], //here you can change the color
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: constraints.maxWidth * 0.8,
                  padding: EdgeInsets.only(top: 5, left: 5),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Medication: ',
                        style: Theme.of(context).textTheme.title,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '$medication',
                          maxLines: 5,
                          style: TextStyle(fontSize: 18),
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
  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Medication",
                        ),
                        controller: medicaionController,
                        keyboardType: TextInputType.text,
                        maxLength: 60,
                      ),
                      Container(
                        margin: EdgeInsets.all(30),
                        child: FlatButton(
                          onPressed: ()=>saveNewMedication(medicaionController.text),
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
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }
}

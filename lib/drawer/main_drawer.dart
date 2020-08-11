import 'package:amun/drawer/allergies_screen.dart';
import 'package:amun/drawer/condtions_screen.dart';
import 'package:amun/drawer/edit_patient_info_screen.dart';
import 'package:amun/drawer/facility_screen.dart';
import 'package:amun/drawer/medications_screen.dart';
import 'package:amun/drawer/doctors_screen.dart';
import 'package:amun/models/Responses/PatientResponse.dart';
import 'package:amun/models/Patient.dart';

import 'package:amun/screens/categories_screen.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:amun/models/Patient.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {


  Patient patient;
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
          .getPatientService()
          .getPatient(_patientToken)
          .then((PatientResponse response) {
        if (response.success) {
          //  DialogManager.stopLoadingDialog(context);
          patient = response.patient;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: mediaQuery.height * 0.07),
          child: Column(
            children: <Widget>[
              Container(
                child: FutureBuilder(
                  future: userFuture,
                  builder: (ctx, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("none");
                        break;
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return   ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            height: mediaQuery.height * 0.25,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  //margin: EdgeInsets.only(top:20),
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(top: 15, left: 15),
                                      child: Text('')),
                                ),
                                Divider(),
                                Container(
                                    margin: EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    child: Text('')),
                                Divider(),
                                Container(
                                    margin: EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    child:  Text('')),
                                Divider(),
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 15, bottom: 15),
                                    alignment: Alignment.centerLeft,
                                    child: Text('')),
                              ],
                            ),
                          ),
                        );
                        break;
                      case ConnectionState.done:
                        return ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            height: mediaQuery.height * 0.25,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            color: Theme.of(context).primaryColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  //margin: EdgeInsets.only(top:20),
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(top: 15, left: 15),
                                      child: buildMyText(context, "Name",
                                          "${patient.firstName} ${patient.lastName}")),
                                ),
                                Divider(),
                                Container(
                                    margin: EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    child: buildMyText(
                                        context, "Username", patient.username)),
                                Divider(),
                                Container(
                                    margin: EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    child: buildMyText(context, "Birth Date",
                                        "${DateFormat.yMd().format(patient.birthDate)}")),
                                Divider(),
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 15, bottom: 15),
                                    alignment: Alignment.centerLeft,
                                    child: buildMyText(context, "Blood Type",
                                        patient.bloodType)),
                              ],
                            ),
                          ),
                        );
                        break;
                    }
                  },
                ),
              ),

              SizedBox(
                height: 10,
              ),
              buildListTile(context, 'Home', () {
                Navigator.pushNamedAndRemoveUntil(
                    context, CategoriesScreen.routeName, (r) => false);
              }),
              buildListTile(context, 'My Doctors', () {
                Navigator.pushNamedAndRemoveUntil(
                    context, CategoriesScreen.routeName, (r) => false);
                Navigator.pushNamed(context, DoctorsScreen.routeName,
                    arguments: {'screen title': 'My Doctors'});
              }),

              buildListTile(context, 'Facilities', () {
                Navigator.pushNamedAndRemoveUntil(
                    context, CategoriesScreen.routeName, (r) => false);
                Navigator.pushNamed(context, FacilityScreen.routeName);
              }),
              buildListTile(context, 'Allergies', () {
                Navigator.pushNamedAndRemoveUntil(
                    context, CategoriesScreen.routeName, (r) => false);
                Navigator.pushNamed(context, AllergiesScreen.routeName,
                    arguments: {'allergies': patient.allergies});
              }),
              buildListTile(context, 'Medications', () {
                Navigator.pushNamedAndRemoveUntil(
                    context, CategoriesScreen.routeName, (r) => false);
                Navigator.pushNamed(context, MedicationsScreen.routeName,
                    arguments: {'medications': patient.medications});
              }),
              buildListTile(context, 'Conditions', () {
                Navigator.pushNamedAndRemoveUntil(
                    context, CategoriesScreen.routeName, (r) => false);
                Navigator.pushNamed(context, ConditionsScreen.routeName,
                    arguments: {'conditions': patient.conditions});
              }),
              buildListTile(context, 'Edit information', () {
                Navigator.pushNamedAndRemoveUntil(
                    context, CategoriesScreen.routeName, (r) => false);
                Navigator.pushNamed(context, EditPatientInfo.routeName,
                    arguments: {'information': patient});
              }),
              Container(
                color: Theme.of(context).accentColor,
                child: buildListTile(context, 'Logout', () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(BuildContext ctx, String title, Function tabHandler) {
    return ListTile(
      title: Card(
        elevation: 1,
        child: Center(
          heightFactor: 2,
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'RobotoCondenced',
                fontSize: 18,
                color: Theme.of(ctx).primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: tabHandler,
    );
  }

  Widget buildMyText(BuildContext ctx, String title, String value) {
    return Container(
          child: Row(
        children: <Widget>[
      Text("$title: ",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Theme.of(ctx).accentColor)),
      FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: <Widget>[
            Text("$value",
                style: TextStyle(
                  fontSize: 16,
                )),
          ],
        ),
      ),
        ],
      ),
    );
  }
}


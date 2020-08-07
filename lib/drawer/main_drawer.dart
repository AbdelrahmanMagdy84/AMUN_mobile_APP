import 'package:amun/drawer/allergies_screen.dart';
import 'package:amun/drawer/condtions_screen.dart';
import 'package:amun/drawer/edit_patient_info_screen.dart';
import 'package:amun/drawer/facility_screen.dart';
import 'package:amun/drawer/medications_screen.dart';
import 'package:amun/drawer/doctors_screen.dart';
import 'package:amun/screens/categories_screen.dart';
import 'package:amun/screens/login_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final String name = "Abdelrahman Magdy";
  final username = "Ab!223344";
  final String age = "55";
  final String bloodType = "A Positive";

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: mediaQuery.height * 0.07),
          child: Column(
            children: <Widget>[
              // Container(
              //   height: 1,
              //   color: Theme.of(context).accentColor,
              // ),
              ClipRRect(
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
                            margin: EdgeInsets.only(top: 15, left: 15),
                            child: buildMyText(context, "Name", name)),
                      ),
                      Divider(),
                      Container(
                          margin: EdgeInsets.only(left: 15),
                          alignment: Alignment.centerLeft,
                          child: buildMyText(context, "Username", username)),
                      Divider(),
                      Container(
                          margin: EdgeInsets.only(left: 15),
                          alignment: Alignment.centerLeft,
                          child: buildMyText(context, "Age", age)),
                      Divider(),
                      Container(
                          margin: EdgeInsets.only(left: 15, bottom: 15),
                          alignment: Alignment.centerLeft,
                          child: buildMyText(context, "Blood Type", bloodType)),
                    ],
                  ),
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
                Navigator.pushNamed(
                  context,
                  AllergiesScreen.routeName,
                );
              }),
              buildListTile(context, 'Medications', () {
                Navigator.pushNamedAndRemoveUntil(
                    context, CategoriesScreen.routeName, (r) => false);
                Navigator.pushNamed(
                  context,
                  MedicationsScreen.routeName,
                );
              }),
              buildListTile(context, 'Conditions', () {
                Navigator.pushNamedAndRemoveUntil(
                    context, CategoriesScreen.routeName, (r) => false);
                Navigator.pushNamed(
                  context,
                  ConditionsScreen.routeName,
                );
              }),
              buildListTile(context, 'Edit information', () {
                Navigator.pushNamedAndRemoveUntil(
                    context, CategoriesScreen.routeName, (r) => false);
                Navigator.pushNamed(
                  context,
                  EditPatientInfo.routeName,
                );
              }),
              Container(
                color: Theme.of(context).accentColor,
                child: buildListTile(context, 'Logout', () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,'/', (r) => false);
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
          child: Text("$value",
              style: TextStyle(
                fontSize: 16,
              )),
        ),
      ],
    ));
  }
}

import 'package:amun/drawer/allergies_screen.dart';
import 'package:amun/drawer/condtions_screen.dart';
import 'package:amun/drawer/my_doctors_screen.dart';
import 'package:amun/screens/categories_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final String name = "Abdelrahman Magdy";
  final username = "Ab!223344";
  final String age = "55";
  final String bloodType = "A Positive";
  Widget buildListTile(
      BuildContext ctx, String title, IconData icon, Function tabHandler) {
    return ListTile(
      // leading: Icon(
      //   icon,
      //   size: 26,
      //),
      title: Card(
        elevation: 1,
        child: Center(
          heightFactor: 2,
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'RobotoCondenced',
                fontSize: 26,
                color: Theme.of(ctx).primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: tabHandler,
    );
  }

  Widget buildMyText(BuildContext ctx, String lead, String rhs) {
    return Container(
        child: Row(
      children: <Widget>[
        Text("$lead: ",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Theme.of(ctx).accentColor)),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text("$rhs",
              style: TextStyle(
                fontSize: 16,
              )),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Drawer(
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
              height: 20,
            ),
            buildListTile(context, 'Home', Icons.home, () {
              Navigator.of(context)
                  .pushReplacementNamed(CategoriesScreen.routeName);
            }),
            buildListTile(context, 'My Doctors', Icons.settings, () {
              Navigator.of(context).popAndPushNamed(MyDoctorsScreen.routeName,
                  arguments: {'screen title': 'My Doctors'});
            }),
            buildListTile(context, 'Facilities', Icons.settings, () {
              Navigator.of(context).popAndPushNamed(MyDoctorsScreen.routeName,
                  arguments: {'screen title': 'Facilities'});
            }),
            //buildListTile(context, 'Medecines', Icons.healing, () {}),
            buildListTile(context, 'Allergies', Icons.tag_faces, () {
              Navigator.of(context).popAndPushNamed(AllergiesScreen.routeName);
            }),
             buildListTile(context, 'Conditions', Icons.tag_faces, () {
              Navigator.of(context).popAndPushNamed(ConditionsScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }
}

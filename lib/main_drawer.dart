import 'package:amun/screens/allergies_screen.dart';

import './screens/categories_screen.dart';
import './screens/my_doctors_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text("Name:",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                )),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(context, 'Home', Icons.home, () {
            Navigator.of(context)
                .pushReplacementNamed(CategoriesScreen.routeName);
          }),
          buildListTile(context, 'My Doctors', Icons.settings, () {
            Navigator.of(context).pushNamed(MyDoctorsScreen.routeName,
                arguments: {'screen title': 'My Doctors'});
          }),
          buildListTile(context, 'Facilities', Icons.settings, () {
            Navigator.of(context).pushNamed(MyDoctorsScreen.routeName,
                arguments: {'screen title': 'Facilities'});
          }),
          buildListTile(context, 'Medecines', Icons.healing, () {}),
          buildListTile(context, 'Allergies', Icons.tag_faces, () {
            Navigator.of(context).pushNamed(AllergiesScreen.routeName);
          }),
        ],
      ),
    );
  }
}

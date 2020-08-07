import 'package:amun/drawer/main_drawer.dart';
import 'package:amun/drawer/profile_screen.dart';
import 'package:flutter/material.dart';

class MyDoctorsScreen extends StatefulWidget {
  static final routeName = 'Doctors';

  @override
  _MyDoctorsScreenState createState() => _MyDoctorsScreenState();
}

class _MyDoctorsScreenState extends State<MyDoctorsScreen> {
  // String doctorName = 'Ahmed Abdelrahman';
  // String specialization = 'x';
  // String facilityName = 'Dar eh foad';

  String screenTitle;
  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    screenTitle = routeArgs['screen title'];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: ListTile(
              leading: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "search",
                  ),
                ),
              ),
              title: Icon(
                Icons.search,
                size: 34,
              ),
            ),
          ),
          GestureDetector(
            child: item('ahmed', 'ahmedMecky123', 'عظام'),
            onTap: () =>
                Navigator.of(context).pushNamed(ProfileScreen.routeName),
          ),
        ],
      ),
    );
  }
}

Widget item(String name, String username, String specialization) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          height: MediaQuery.of(context).size.height * 0.22,
          child: Container(
            child: Card(
              elevation: 4,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: constraints.maxWidth * 0.8,
                      padding: EdgeInsets.only(top: 5, left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Name: $name',
                              overflow: TextOverflow.visible,
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Username: $username ',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            // padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Specialization: $specialization ',
                              overflow: TextOverflow.visible,
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ),
          ));
    },
  );
}

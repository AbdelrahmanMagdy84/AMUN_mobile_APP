import 'package:amun/drawer/allergies_screen.dart';
import 'package:amun/drawer/condtions_screen.dart';
import 'package:amun/drawer/main_drawer.dart';
import 'package:amun/reminders/ui/homescreen/reminders_screen.dart';
import 'package:amun/reminders/ui/new_entry/new_entry.dart';
import 'package:amun/screens/blood_pressure_screen.dart';
import 'package:amun/screens/glucose_screen.dart';
import 'package:amun/screens/prescription_screen.dart';
import 'package:amun/screens/reminder_screen.dart';
import 'package:amun/screens/show_image_screen.dart';
import './screens/login_screen.dart';
import './screens/register_screen.dart';
import './screens/scanner_screen.dart';
import './screens/categories_screen.dart';
import 'package:flutter/material.dart';

import 'drawer/my_doctors_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.amber,
          accentColor: Color(0xff10AD91),
          primarySwatch: Colors.blue,
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    color: Color(0xff10AD91),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
        MyDoctorsScreen.routeName: (ctx) => MyDoctorsScreen(),
        AllergiesScreen.routeName: (ctx) => AllergiesScreen(),
        ScannerScreen.routeName: (ctx) => ScannerScreen(),
        RemindersScreen.routeName: (ctx) => RemindersScreen(),
        NewEntry.routeName: (ctx) => NewEntry(),
        ShowImageScreen.routeName:(ctx)=>ShowImageScreen(),
        PrescriptionScreen.routeName:(ctx)=>PrescriptionScreen(),
        BloodPressureScreen.routeName:(ctx)=>BloodPressureScreen(),
        BloodGlucoseScreen.routeName:(ctx)=>BloodGlucoseScreen(),
        ConditionsScreen.routeName:(ctx)=>ConditionsScreen(),
        ReminderScreen.routeName:(ctx)=>ReminderScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MainDrawer(),
      body: Container(
        color: Colors.black,
        child: GridView(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

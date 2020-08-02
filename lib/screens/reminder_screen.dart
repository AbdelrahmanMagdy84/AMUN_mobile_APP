import 'package:amun/screens/blood_pressure_screen.dart';
import 'package:amun/screens/categories_screen.dart';
import 'package:amun/screens/glucose_screen.dart';
import 'package:flutter/material.dart';
import 'package:amun/reminders/global_bloc.dart';
import 'package:amun/reminders/ui/homescreen/reminders_screen.dart';
import 'package:amun/reminders/ui/new_entry/new_entry.dart';
import 'package:amun/screens/allergies_screen.dart';
import 'package:amun/screens/my_doctors_screen.dart';
import 'package:amun/screens/register_screen.dart';
import 'package:amun/screens/scanner_screen.dart';
import 'package:amun/screens/show_image_screen.dart';
import 'package:provider/provider.dart';
import 'categories_screen.dart';

class ReminderScreen extends StatefulWidget {
  static final String routeName = "reminder route name";
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
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
        home: RemindersScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          RemindersScreen.routeName: (ctx) => RemindersScreen(),
          CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
          NewEntry.routeName: (ctx) => NewEntry(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          // CategoryRecordsScreen.routeName: (ctx) => CategoryRecordsScreen(),
          MyDoctorsScreen.routeName: (ctx) => MyDoctorsScreen(),
          AllergiesScreen.routeName: (ctx) => AllergiesScreen(),
          ScannerScreen.routeName: (ctx) => ScannerScreen(),
          NewEntry.routeName: (ctx) => NewEntry(),
          ShowImageScreen.routeName: (ctx) => ShowImageScreen(),
          MyDoctorsScreen.routeName: (ctx) => MyDoctorsScreen(),
          AllergiesScreen.routeName: (ctx) => AllergiesScreen(),
          ScannerScreen.routeName: (ctx) => ScannerScreen(),
          RemindersScreen.routeName: (ctx) => RemindersScreen(),
          NewEntry.routeName: (ctx) => NewEntry(),
          ShowImageScreen.routeName: (ctx) => ShowImageScreen(),
          // PrescriptionScreen.routeName:(ctx)=>PrescriptionScreen(),
          BloodPressureScreen.routeName: (ctx) => BloodPressureScreen(),
          BloodGlucoseScreen.routeName: (ctx) => BloodGlucoseScreen(),
          ReminderScreen.routeName: (ctx) => ReminderScreen()
        },
      ),
    );
  }
}

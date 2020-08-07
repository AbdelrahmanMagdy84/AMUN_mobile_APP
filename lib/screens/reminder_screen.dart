import 'package:amun/drawer/condtions_screen.dart';
import 'package:amun/drawer/facility_screen.dart';
import 'package:amun/screens/blood_pressure_screen.dart';
import 'package:amun/screens/categories_screen.dart';
import 'package:amun/screens/glucose_screen.dart';
import 'package:amun/screens/lab_test_screen.dart';
import 'package:amun/screens/radiograph_screen.dart';
import 'package:flutter/material.dart';
import 'package:amun/reminders/global_bloc.dart';
import 'package:amun/reminders/ui/homescreen/reminders_screen.dart';
import 'package:amun/reminders/ui/new_entry/new_entry.dart';
import 'package:amun/drawer/allergies_screen.dart';
import 'package:amun/drawer/doctors_screen.dart';
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
          ReminderScreen.routeName: (ctx) => ReminderScreen(),
          CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
          NewEntry.routeName: (ctx) => NewEntry(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          DoctorsScreen.routeName: (ctx) => DoctorsScreen(),
          AllergiesScreen.routeName: (ctx) => AllergiesScreen(),
          ScannerScreen.routeName: (ctx) => ScannerScreen(),
          ShowImageScreen.routeName: (ctx) => ShowImageScreen(),
          BloodPressureScreen.routeName: (ctx) => BloodPressureScreen(),
          BloodGlucoseScreen.routeName: (ctx) => BloodGlucoseScreen(),
          ConditionsScreen.routeName: (ctx) => ConditionsScreen(),
          RadiographScreen.routeName: (ctx) => RadiographScreen(),
          LabTestScreen.routeName: (ctx) => LabTestScreen(),
          FacilityScreen.routeName: (ctx) => FacilityScreen(),
        },
      ),
    );
  }
}

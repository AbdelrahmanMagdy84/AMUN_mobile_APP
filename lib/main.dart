import 'package:amun/drawer/allergies_screen.dart';
import 'package:amun/drawer/condtions_screen.dart';
import 'package:amun/drawer/doctor_profile_screen.dart';
import 'package:amun/drawer/doctors_connections_screen.dart';
import 'package:amun/drawer/doctors_screen.dart';
import 'package:amun/drawer/edit_patient_info_screen.dart';
import 'package:amun/drawer/clerk_profile_screen.dart';
import 'package:amun/reminders/ui/homescreen/reminders_screen.dart';
import 'package:amun/reminders/ui/new_entry/new_entry.dart';

import 'package:amun/screens/blood_pressure_screen.dart';
import 'package:amun/screens/glucose_screen.dart';
import 'package:amun/screens/lab_test_screen.dart';
import 'package:amun/screens/prescription_screen.dart';
import 'package:amun/screens/radiograph_screen.dart';
import 'package:amun/screens/reminder_screen.dart';
import 'package:amun/screens/show_image_screen.dart';
import 'package:amun/screens/success_screen.dart';
import './screens/login_screen.dart';
import './screens/register_screen.dart';
import './screens/scanner_screen.dart';
import './screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'drawer/facility_screen.dart';
import 'drawer/medications_screen.dart';
import 'package:amun/drawer/facility_profile_screen.dart';

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
        ScannerScreen.routeName: (ctx) => ScannerScreen(),
        DoctorsScreen.routeName: (ctx) => DoctorsScreen(),
        AllergiesScreen.routeName: (ctx) => AllergiesScreen(),
        ConditionsScreen.routeName: (ctx) => ConditionsScreen(),
        RemindersScreen.routeName: (ctx) => RemindersScreen(),
        NewEntry.routeName: (ctx) => NewEntry(),
        ShowImageScreen.routeName: (ctx) => ShowImageScreen(),
        PrescriptionScreen.routeName: (ctx) => PrescriptionScreen(),
        BloodPressureScreen.routeName: (ctx) => BloodPressureScreen(),
        BloodGlucoseScreen.routeName: (ctx) => BloodGlucoseScreen(),
        ReminderScreen.routeName: (ctx) => ReminderScreen(),
        RadiographScreen.routeName: (ctx) => RadiographScreen(),
        LabTestScreen.routeName: (ctx) => LabTestScreen(),
        FacilityScreen.routeName: (ctx) => FacilityScreen(),
        EditPatientInfo.routeName: (ctx) => EditPatientInfo(),
        MedicationsScreen.routeName: (ctx) => MedicationsScreen(),
        ClerkProfileScreen.routeName: (ctx) => ClerkProfileScreen(),
        DoctorProfileScreen.routeName: (ctx) => DoctorProfileScreen(),
        FacilityProfileScreen.routeName: (ctx) => FacilityProfileScreen(),
        SuccessScreen.routeName:(ctx)=>SuccessScreen(),
        DoctorConnectionScreen.routeName:(ctx)=>DoctorConnectionScreen(),
      },
    );
  }
}

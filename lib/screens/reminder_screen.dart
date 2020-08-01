import 'package:amun/screens/categories_screen.dart';
import 'package:amun/screens/category_records_screen.dart';
import 'package:flutter/material.dart';
import 'package:amun/Prescription_handler/bloc/prescription_bloc.dart';
import 'package:amun/Prescription_handler/event/set_prescriptions.dart';
import 'package:amun/db/database_provider.dart';
import 'package:amun/input_widgets/new_prescription.dart';
import 'package:amun/items/prescription_item.dart';
import 'package:amun/reminders/global_bloc.dart';
import 'package:amun/reminders/ui/homescreen/reminders_screen.dart';
import 'package:amun/reminders/ui/new_entry/new_entry.dart';
import 'package:amun/screens/allergies_screen.dart';
import 'package:amun/screens/blood_pressure_screen.dart';
import 'package:amun/screens/glucose_screen.dart';
import 'package:amun/screens/my_doctors_screen.dart';
import 'package:amun/screens/prescription_screen.dart';
import 'package:amun/screens/register_screen.dart';
import 'package:amun/screens/scanner_screen.dart';
import 'package:amun/screens/show_image_screen.dart';

import 'package:provider/provider.dart';
import '../input_widgets/new_glucose.dart';
import '../input_widgets/new_pressure.dart';
import '../items/glucose_item.dart';
import '../items/pressure_item.dart';
import '../models/category.dart';
import 'package:flutter/material.dart';

import 'categories_screen.dart';

class ReminderScreen extends StatefulWidget {
  static final String routeName="reminder route name";
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

GlobalBloc globalBloc;

class _ReminderScreenState extends State<ReminderScreen> {
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
            CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
            NewEntry.routeName: (ctx) => NewEntry(),
            RegisterScreen.routeName: (ctx) => RegisterScreen(),
           // CategoryRecordsScreen.routeName: (ctx) => CategoryRecordsScreen(),
            MyDoctorsScreen.routeName: (ctx) => MyDoctorsScreen(),
            AllergiesScreen.routeName: (ctx) => AllergiesScreen(),
            ScannerScreen.routeName: (ctx) => ScannerScreen(),
            RemindersScreen.routeName: (ctx) => RemindersScreen(),
            NewEntry.routeName: (ctx) => NewEntry(),
            ShowImageScreen.routeName: (ctx) => ShowImageScreen(),
          },
        ),
      );
  }
}

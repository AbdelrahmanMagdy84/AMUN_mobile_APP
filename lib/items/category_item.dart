import 'package:amun/screens/blood_pressure_screen.dart';
import 'package:amun/screens/category_records_screen.dart';
import 'package:amun/screens/glucose_screen.dart';
import 'package:amun/screens/lab_test_screen.dart';
import 'package:amun/screens/prescription_screen.dart';
import 'package:amun/screens/radiograph_screen.dart';
import 'package:amun/screens/reminder_screen.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String id;
  final String image;
  CategoryItem(this.id, this.title, this.image);

  void selectCategory(BuildContext ctx) {
    switch (id) {
      case '1':
        Navigator.of(ctx).pushNamed(BloodGlucoseScreen.routeName);
        break;
      case '2':
        Navigator.of(ctx).pushNamed(BloodPressureScreen.routeName);
        break;
      case '3':
        Navigator.of(ctx).pushNamed(PrescriptionScreen.routeName);
        break;
      case '4':
        Navigator.of(ctx).pushNamed(ReminderScreen.routeName);
        break;
      case '5':
        Navigator.of(ctx).pushNamed(RadiographScreen.routeName);
        break;
      case '6':
        Navigator.of(ctx).pushNamed(LabTestScreen.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("$image");
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return InkWell(
          onTap: () => selectCategory(context),
          borderRadius: BorderRadius.circular(15),
          splashColor: Theme.of(context).primaryColor,
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      height: constraints.minHeight * 0.7,
                      width: constraints.minWidth * 0.7,
                    )),
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0),
                  Theme.of(context).primaryColor
                ], //here you can change the color
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
    );
  }
}

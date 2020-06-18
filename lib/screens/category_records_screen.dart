import 'package:amun/reminders/global_bloc.dart';
import 'package:amun/reminders/ui/homescreen/reminders_screen.dart';
import 'package:provider/provider.dart';

import '../input_widgets/new_glucose.dart';
import '../input_widgets/new_pressure.dart';
import '../widgets/radiograph_item.dart';
import '../widgets/glucose_item.dart';
import '../widgets/pressure_item.dart';
import '../models/category.dart';
import 'package:flutter/material.dart';

class CategoryRecordsScreen extends StatefulWidget {
  static const routeName = "Category_records";
  List<Category> records;

  CategoryRecordsScreen();

  @override
  _CategoryRecordsScreenState createState() => _CategoryRecordsScreenState();
}

class _CategoryRecordsScreenState extends State<CategoryRecordsScreen> {
  String categoryTitle;
  String categoryId;
  List<Category> displayedRecords;

  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    categoryId = routeArgs['id'];
    super.didChangeDependencies();
  }

  Widget selectItemType() {
    Widget chosenWidget;
    //setState((){
    switch (categoryId) {
      case '1':
        chosenWidget = GlucoseItem();
        break;
      case '2':
        chosenWidget = PressureItem();
        break;
      case '3':
        break;
      case '4':
        chosenWidget = RemindersScreen();

        break;
      case '5':
        break;
    }
    //});
    return chosenWidget;
  }

  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: selectNewRecordType(),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  Widget selectNewRecordType() {
    Widget chosenWidget;
    switch (categoryId) {
      case '1':
        chosenWidget = NewGlucose();
        break;
      case '2':
        chosenWidget = NewPressure();
        break;
      case '3':
        break;
      case '4':
        chosenWidget = Text('');
        break;
      case '5':
        break;
    }
    return chosenWidget;
  }

  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget selected = selectItemType();
    if (categoryTitle == "Reminders") {
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
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "$categoryTitle",
            style: Theme.of(context).textTheme.title,
          ),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return selected;
          },
          itemCount: 1,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => startAddNewRecord(context),
          child: Icon(
            Icons.add,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }
  }
}

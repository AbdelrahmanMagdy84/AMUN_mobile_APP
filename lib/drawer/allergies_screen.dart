import 'package:amun/drawer/main_drawer.dart';
import 'package:amun/input_widgets/new_allergy.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllergiesScreen extends StatefulWidget {
  static final routeName = 'allergies screen';

  @override
  _AllergiesScreenState createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  String allergy;
  String allergyType;
  DateTime date;

  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    
    setState(() {
      if (routeArgs != null) {
        allergy = routeArgs['allergy'];
        allergyType = routeArgs['type'];
        date = routeArgs['date'];
      }
    });

    super.didChangeDependencies();
  }

  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        enableDrag: false,
        builder: (_) {
          return NewAllergy();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Allergies')),
      drawer: MainDrawer(),
      body: allergy == null
          ? Center(child: Text('no allergies yet'))
          : LayoutBuilder(builder: (context, constraints) {
              return Container(

                child: Column(children: <Widget>[
                  Container(
                   padding: EdgeInsets.only(top:10),
                    child: Card(
                      elevation: 4,
                      child: Column(
                        children: <Widget>[
                          FittedBox(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 10,bottom: 5),
                              child: Text(
                                '$allergy',
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: constraints.maxWidth * 0.8,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FittedBox(
                                        child: Container(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            'Type: $allergyType ',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Text(
                                         'Date: ${DateFormat.yMMMd().format(date)}',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: constraints.maxWidth * 0.1,
                                  alignment: Alignment.centerLeft,
                                  child: Expanded(
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Theme.of(context).errorColor,
                                        ),
                                        onPressed: () {}),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            }),
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

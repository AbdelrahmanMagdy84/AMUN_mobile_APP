import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'main_drawer.dart';

class MedicationsScreen extends StatefulWidget {
  static final routeName = 'Medication route';

  @override
  _MedicationsScreenState createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  String medication =
      "asasasasaaaaaaaaaaaaaaaaaaaaaasaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaax";

  @override
  Widget build(BuildContext context) {
    print("--------------");
    print(medication.length);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Medications'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
            mainAxisSpacing: MediaQuery.of(context).size.height * 0.05,
            children: <Widget>[
              buildItem(),
            ]),
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

  Widget buildItem() {
    return Container(
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(.2),
                    Theme.of(context).primaryColor
                  ], //here you can change the color
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: constraints.maxWidth * 0.8,
                  padding: EdgeInsets.only(top: 5, left: 5),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Medication: ',
                        style: Theme.of(context).textTheme.title,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '$medication',
                          maxLines: 5,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  final medicaionController = TextEditingController();
  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Medication",
                        ),
                        controller: medicaionController,
                        keyboardType: TextInputType.text,
                        maxLength: 60,
                      ),
                      Container(
                        margin: EdgeInsets.all(30),
                        child: FlatButton(
                          onPressed: null,
                          color: Theme.of(context).accentColor,
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }
}

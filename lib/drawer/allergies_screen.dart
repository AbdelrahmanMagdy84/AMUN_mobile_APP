import 'package:amun/drawer/main_drawer.dart';
import 'package:amun/input_widgets/new_allergy.dart';
import 'package:amun/static_data/allergy_data.dart';
import 'package:flutter/material.dart';

class AllergiesScreen extends StatefulWidget {
  static final routeName = 'allergies screen';

  @override
  _AllergiesScreenState createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  String allergyType;
  List<String> allergies;
  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    setState(() {
      if (routeArgs != null) {
        allergies = routeArgs['allergies'];
        allergies=allergies.reversed.toList();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Allergies')),
      drawer: MainDrawer(),
      body: allergies == null
          ? Center(
              child: Text("No Allergies Add"),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return buildItem(allergies[index]);
              },
              itemCount: allergies.length,
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

  Widget buildItem(String allergy) {
    String type = selectAllergyCategory(allergy);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Card(
              elevation: 4,
              child: Column(
                children: <Widget>[
                  FittedBox(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 10, bottom: 5),
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
                                    'Type: $type',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth * 0.1,
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
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
    });
  }

  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        enableDrag: false,
        builder: (_) {
          return NewAllergy(allergies.reversed.toList());
        });
  }

  String selectAllergyCategory(String allergy) {
    String category;
    if (respiratoryAllergies.contains("       -$allergy")) {
      category = "Respiratory Allergy";
    } else if (foodAllergies.contains("       -$allergy")) {
      category = "food Allergy";
    } else if (skinAllergies.contains("       -$allergy")) {
      category = "Skin Allergy";
    } else {
      category = "other Allergy";
    }
    return category;
  }
}

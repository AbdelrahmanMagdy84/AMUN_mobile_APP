
import 'package:amun/screens/scanner_screen.dart';

import '../widgets/category_item.dart';
import '../medical_categories_data.dart';
import '../main_drawer.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = 'categories_screen';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(
                Icons.camera_alt,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(ScannerScreen.routeName);
              })
        ],
        title: Text("AMUN MR"),
      ),
      drawer: MainDrawer(),
      drawerScrimColor: Theme.of(context).primaryColor.withOpacity(0.5),
      
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: GridView(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
          ),
          children: <Widget>[
            ...categories
                .map(
                  (cat) =>
                      CategoryItem(cat.id, cat.title, cat.color, cat.image),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

 
}

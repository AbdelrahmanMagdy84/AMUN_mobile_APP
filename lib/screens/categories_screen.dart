import '../widgets/category_item.dart';
import '../medical_categories_data.dart';
import '../main_drawer.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName='categories_screen';
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("AMUN MR"),
      ),
      drawer: MainDrawer(),
      body: Container(
        padding:const EdgeInsets.only(top:20),
        child: GridView(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: mediaQuery.size.height*0.2,
            childAspectRatio: 1/1,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
          ),
          children: <Widget>[
            
            ...categories
                .map(
                  (cat) => CategoryItem(cat.id, cat.title, cat.color,cat.image),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

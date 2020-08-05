import 'package:amun/reminders/global_bloc.dart';
import 'package:amun/screens/scanner_screen.dart';
import 'package:amun/static_data/medical_categories_data.dart';
import '../items/category_item.dart';
import '../drawer/main_drawer.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = 'categories_screen';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
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
      ),
      drawer: MainDrawer(),
      drawerScrimColor: Theme.of(context).primaryColor.withOpacity(0.5),
      body: Column(
        children: <Widget>[
          TopContainer(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.05,
                children: <Widget>[
                  ...categories
                      .map(
                        (cat) => CategoryItem(cat.id, cat.title, cat.image),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    //       //  GridView(
    //       //   padding: EdgeInsets.all(20),
    //       //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(

    //       //     maxCrossAxisExtent: 200,
    //       //     childAspectRatio: 1 / 1,
    //       //     crossAxisSpacing: 15,
    //       //     mainAxisSpacing: 20,
    //       //   ),
    //       //   children: <Widget>[
    //       //     ...categories
    //       //         .map(
    //       //           (cat) =>
    //       //               CategoryItem(cat.id, cat.title, cat.color, cat.image),
    //       //         )
    //       //         .toList(),
    //       //   ],
    //       // ),
    //       ),
    // );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(50, 27),
            bottomRight: Radius.elliptical(50, 27),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey[400],
              offset: Offset(0, 3.5),
            )
          ],
          color: Theme.of(context).primaryColor),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              "AMUN MR",
              style: TextStyle(
                fontFamily: "Angel",
                fontSize: 64,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

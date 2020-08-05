import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'main_drawer.dart';

class ConditionsScreen extends StatefulWidget {
  static final routeName = 'conditions route';

  @override
  _ConditionsScreenState createState() => _ConditionsScreenState();
}

class _ConditionsScreenState extends State<ConditionsScreen> {
  String condition =
      "asasasasaaaaaaaaaaaaaaaaaaaaaasaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaax";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('conditions'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
              mainAxisSpacing: MediaQuery.of(context).size.height * 0.05,
              children: <Widget>[
                buildItem(),
              ]),
        ));
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
                        'Condtion: ',
                        style: Theme.of(context).textTheme.title,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '$condition',
                          maxLines: 4,
                          style: TextStyle(fontSize: 16),
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
}

// Widget item(String condition) {
//   return LayoutBuilder(
//     builder: (context, constraints) {
//       return Container(
//           // padding: EdgeInsets.symmetric(vertical: 10),
//           height: MediaQuery.of(context).size.height * 0.1,
//           child: Card(
//             elevation: 4,
//             child: Padding(
//               padding: EdgeInsets.only(left: 10),
//               child: Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       // width: constraints.maxWidth * 0.8,
//                       padding: EdgeInsets.only(top: 5, left: 5),
//                       child: Container(
//                         padding: EdgeInsets.only(top: 5),
//                         child: Row(
//                           children: <Widget>[
//                             Text(
//                               'Condtion: ',
//                               style: Theme.of(context).textTheme.title,
//                             ),
//                             Container(
//                               color: Colors.amber,
//                               child: Text(
//                                 '$condition',
//                                 maxLines: 4,
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       child: IconButton(
//                           icon: Icon(
//                             Icons.delete,
//                             color: Theme.of(context).errorColor,
//                           ),
//                           onPressed: () {}),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ));
//     },
//   );
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("Conditions"),
//     ),
//     drawer: MainDrawer(),
//     body: Column(
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.all(5),
//           child: item(condition),
//         ),
//       ],
//     ),
//     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     floatingActionButton: FloatingActionButton(
//       onPressed: () {},
//       child: Icon(
//         Icons.add,
//         size: 40,
//         color: Theme.of(context).primaryColor,
//       ),
//     ),
//   );
// }

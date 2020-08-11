import 'package:amun/input_widgets/DialogManager.dart';
import 'package:amun/models/Responses/PatientResponse.dart';
import 'package:amun/screens/categories_screen.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'main_drawer.dart';

class ConditionsScreen extends StatefulWidget {
  static final routeName = 'conditions route';

  @override
  _ConditionsScreenState createState() => _ConditionsScreenState();
}

class _ConditionsScreenState extends State<ConditionsScreen> {
  List<String> conditions;
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    setState(() {
      if (routeArgs != null) {
        conditions = routeArgs['conditions'];
      }
    });
    print("getting user token");
    getUserToken();
    super.didChangeDependencies();
  }

  String _patientToken;
  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });
    });
  }

  void updatePatient(List<String> newConditions) {
    DialogManager.showLoadingDialog(context);
    APIClient()
        .getPatientService()
        .updatePatientList(newConditions, "conditions", _patientToken)
        .then((PatientResponse patientResponse) {
      if (patientResponse.success) {
        DialogManager.stopLoadingDialog(context);
      }
    }).catchError((Object e) {
      DialogManager.stopLoadingDialog(context);
      DialogManager.showErrorDialog(context, "Couldn't Edit");
      print(e.toString());
    });
  }

  void saveNewCondition(String inputCondition) {
    if (_formKey.currentState.validate()) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        List<String> newConditions = conditions;
        newConditions.add(inputCondition);
        updatePatient(newConditions);
        Navigator.pushNamedAndRemoveUntil(
            context, CategoriesScreen.routeName, (r) => false);
        Navigator.pushNamed(context, ConditionsScreen.routeName,
            arguments: {'conditions': newConditions});
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }
  }

  final conditionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> reversedList = conditions.reversed.toList();
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('conditions'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: conditions == null
            ? Center(
                child: Text("Empty press + to add"),
              )
            : GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.05,
                children: List.generate(reversedList.length, (index) {
                  return buildItem(reversedList[index]);
                })),
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

  Widget buildItem(String condition) {
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
                        'Condition: ',
                        style: Theme.of(context).textTheme.title,
                      ),
                       Divider(
                        color: Theme.of(context).accentColor,
                        thickness: 0.6,
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            '$condition',
                            maxLines: 5,
                            style: TextStyle(fontSize: 18),
                          ),
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

  void startAddNewRecord(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Condition",
                          ),
                          controller: conditionController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          maxLength: 60,
                          validator: (String arg) {
                            if (arg.length < 4)
                              return 'condition must be more than 4 charater';
                            else
                              return null;
                          },
                        ),
                        Container(
                          margin: EdgeInsets.all(30),
                          child: FlatButton(
                            onPressed: () =>
                                saveNewCondition(conditionController.text),
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
            ),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
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

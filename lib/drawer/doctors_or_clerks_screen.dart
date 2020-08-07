import 'package:amun/drawer/clerk_profile_screen.dart';
import 'package:amun/drawer/doctor_profile_screen.dart';
import 'package:amun/drawer/main_drawer.dart';
import 'package:amun/models/Doctor.dart';
import 'package:amun/models/Responses/DoctorsResponse.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';

class DoctorsOrClerksScreen extends StatefulWidget {
  static final routeName = 'Doctors';

  @override
  _DoctorsOrClerksScreenState createState() => _DoctorsOrClerksScreenState();
}

class _DoctorsOrClerksScreenState extends State<DoctorsOrClerksScreen> {
  String screenTitle;
  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    screenTitle = routeArgs['screen title'];

    super.didChangeDependencies();
  }

  List<Doctor> doctorList;
  Future userFuture;
  @override
  void initState() {
    super.initState();
    print("getting user token");
    getUserToken();
  }

  String _patientToken;
  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });
      print("token = $_patientToken");
      if (screenTitle == "My Doctors") {
        print("x------------------------------");
        userFuture = APIClient()
            .getFacilityPatientService()
            .getDoctors(_patientToken)
            .then((DoctorsResponse responseList) {
          if (responseList.success) {
            //  DialogManager.stopLoadingDialog(context);
            doctorList = responseList.doctors;
            print("------------------------------");
            print(responseList.doctors.length);
          }else{print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");}
        });
      }
    });
  }

  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      drawer: MainDrawer(),
      // body: Column(
      //   children: <Widget>[
      //     Container(
      //       height: MediaQuery.of(context).size.height * 0.1,
      //       child: ListTile(
      //         leading: Container(
      //           width: MediaQuery.of(context).size.width * 0.8,
      //           child: TextField(
      //             controller: usernameController,
      //             decoration: InputDecoration(
      //               labelText: "search by Username",
      //             ),
      //           ),
      //         ),
      //         title: IconButton(
      //           icon: Icon(
      //             Icons.search,
      //             size: 34,
      //           ),
      //           onPressed: () {
      //             if (usernameController.text != null) {
      //               if (screenTitle == "My Doctors")
      //                 Navigator.of(context).pushNamed(
      //                     DoctorProfileScreen.routeName,
      //                     arguments: {'userName': usernameController.text});
      //               else {
      //                 Navigator.of(context).pushNamed(
      //                     ClerkProfileScreen.routeName,
      //                     arguments: {'userName': usernameController.text});
      //               }
      //             }
      //           },
      //         ),
      //       ),
      //     ),
         body: Container(
            child: FutureBuilder(
              future: userFuture,
              builder: (ctx, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text("none");
                    break;
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(
                        child: Text(
                      "Loading ",
                      style: Theme.of(context).textTheme.title,
                    ));
                    break;
                  case ConnectionState.done:
                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        return item(
                            "${doctorList[index].firstName} ${doctorList[index].lastName}",
                            doctorList[index].username,
                            doctorList[index].specialization,
                            context);
                      },
                      itemCount: doctorList.length,
                    );
                    break;
                }
              },
            ),
          ),
        //],
      //),
    );
  }

  Widget item(String name, String username, String specializationOrRole,
      BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        if (screenTitle == "My Doctors")
          Navigator.of(ctx).pushNamed(DoctorProfileScreen.routeName,
              arguments: {'userName': username});
        else {
          Navigator.of(ctx).pushNamed(ClerkProfileScreen.routeName,
              arguments: {'userName': username});
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.of(context).size.height * 0.22,
              child: Container(
                child: Card(
                  elevation: 4,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: constraints.maxWidth * 0.8,
                          padding: EdgeInsets.only(top: 5, left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Name: $name',
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Username: $username ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                // padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  screenTitle == 'My Doctors'
                                      ? 'Specialization: $specializationOrRole '
                                      : 'Role: $specializationOrRole',
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                              onPressed: () {}),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
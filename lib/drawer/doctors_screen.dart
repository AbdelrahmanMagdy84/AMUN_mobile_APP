import 'package:amun/drawer/doctor_profile_screen.dart';
import 'package:amun/drawer/main_drawer.dart';
import 'package:amun/models/Connection.dart';
import 'package:amun/models/Doctor.dart';
import 'package:amun/models/MedicalFacility.dart';

import 'package:amun/models/Responses/FacilityPatientResponseList.dart';
import 'package:amun/screens/categories_screen.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';

class DoctorsScreen extends StatefulWidget {
  static final routeName = 'Doctors';

  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  String medicalFacility_ID;
  @override
  didChangeDependencies() {
    getUserToken();
    super.didChangeDependencies();
  }

  //List<Doctor> doctorList = List();
  List<FacilityPatient> connections = List();
  Future userFuture;

  String _patientToken;
  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });

      userFuture = APIClient()
          .getFacilityPatientService()
          .getConnections(_patientToken)
          .then((FacilityPatientResponseList responseList) {
        if (responseList.success) {
          connections = responseList.connection;
          print(connections);
          //connections = connections.reversed.toList();
        }
      });
    });
  }

  void deleteConnection(String id) {
    APIClient()
        .getFacilityPatientService()
        .deleteConnection(id, _patientToken)
        .then((dynamic response) {
      if (response) {
        print("Connection deleted");
      }
    });
  }

  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Doctors"),
      ),
      drawer: MainDrawer(),
      body: Container(
        child: Container(
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
                  return connections == []
                      ? Center(child: Text("no doctors"))
                      : ListView.builder(
                          itemBuilder: (ctx, index) {
                            return item(
                                connections[index].id,
                                "${connections[index].doctor.firstName} ${connections[index].doctor.lastName}",
                                connections[index].doctor.username,
                                connections[index].doctor.specialization,
                                connections[index].doctor,
                                connections[index].medicalFacility,
                                context);
                          },
                          itemCount: connections.length,
                        );
                  break;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget item(
      String id,
      String name,
      String username,
      String specializationOrRole,
      Doctor myDoctor,
      MedicalFacility facility,
      BuildContext ctx) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            Navigator.of(ctx).pushNamed(DoctorProfileScreen.routeName,
                arguments: {'doctor': myDoctor});
          },
          child: Card(
            elevation: 4,
            child: Row(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Container(
                          child: Container(
                            child: Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: constraints.maxWidth * 0.8,
                                  padding: EdgeInsets.only(top: 5, left: 10),
                                  child: Flex(
                                    direction: Axis.vertical,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Name: DR.$name',
                                          style:
                                              Theme.of(context).textTheme.title,
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          'Username: $username ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Divider(),
                                      Expanded(
                                        child: Container(
                                          // padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            'Specialization: $specializationOrRole ',
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      Expanded(
                                        child: Container(
                                          // padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            'Medical Facilitty: ${facility.name} ',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () {
                    setState(() {
                      deleteConnection(id);
                      Navigator.of(context).pop();
                      Navigator.pushNamedAndRemoveUntil(
                          context, CategoriesScreen.routeName, (r) => false);
                      Navigator.pushNamed(
                        context,
                        DoctorsScreen.routeName,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

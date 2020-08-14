import 'package:amun/drawer/doctor_profile_screen.dart';
import 'package:amun/drawer/doctors_screen.dart';
import 'package:amun/drawer/main_drawer.dart';
import 'package:amun/models/Doctor.dart';
import 'package:amun/models/FacilityPatient.dart';
import 'package:amun/models/Responses/DoctorsResponse.dart';
import 'package:amun/screens/categories_screen.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';

class DoctorConnectionScreen extends StatefulWidget {
  static final routeName = 'connection screen';

  @override
  _DoctorConnectionScreenState createState() => _DoctorConnectionScreenState();
}

class _DoctorConnectionScreenState extends State<DoctorConnectionScreen> {
  String medicalFacility_ID;
  FacilityPatient connection = new FacilityPatient();
  List<Doctor> myDoctors = List();
  List<Doctor> filteredDoctors = List();
  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    medicalFacility_ID = routeArgs['id'];
    myDoctors = routeArgs['myDoctors'];
    print(medicalFacility_ID);
    getUserToken();
    super.didChangeDependencies();
  }

  List<Doctor> doctorList = List();
  Future userFuture;

  String _patientToken;
  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });
      print(_patientToken);

      userFuture = APIClient()
          .getFacilityDoctorService()
          .getDoctors(medicalFacility_ID, _patientToken)
          .then((DoctorsResponse responseList) {
        print(responseList.success);

        if (responseList.success) {
          doctorList = responseList.doctors;
          filteredDoctors=  List.from(doctorList);
         
          doctorList.forEach((element) {
            myDoctors.forEach((myElement) {
              if (myElement.username == element.username) {
                filteredDoctors.remove(element);
              }
            }
            );
          });

          
          print('x');
        }
      });
    });
  }

  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connections"),
      ),
      drawer: MainDrawer(),
      body: Container(
        child: Container(
          child: FutureBuilder(
            future: userFuture,
            builder: (ctx, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("zxxxxxxxxxxxxxxxxxxxx");
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
                          "${filteredDoctors[index].firstName} ${filteredDoctors[index].lastName}",
                          filteredDoctors[index].username,
                          filteredDoctors[index].specialization,
                          filteredDoctors[index],
                          filteredDoctors[index].email,
                          context);
                    },
                    itemCount: filteredDoctors.length,
                  );
                  break;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget item(String name, String username, String specializationOrRole,
      Doctor myDoctor, String email, BuildContext ctx) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height * 0.35,
                child: Container(
                  child: Card(
                    elevation: 4,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Name: DR.$name',
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                ),
                                Divider(),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Username: $username ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(),
                                Container(
                                  // padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Email: $email',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Divider(),
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      'Specialization: $specializationOrRole ',
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 10.0, left: 10),
                                        child: FlatButton(
                                          color: Theme.of(context).accentColor,
                                          onPressed: () {
                                            connection.doctor = myDoctor.id;
                                            connection.medicalFacility =
                                                medicalFacility_ID;
                                            userFuture = APIClient()
                                                .getFacilityPatientService()
                                                .createConnection(
                                                    connection, _patientToken)
                                                .then((dynamic response) {
                                              print(response);

                                              if (response['success']) {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        CategoriesScreen
                                                            .routeName,
                                                        (r) => false);
                                                Navigator.pushNamed(context,
                                                    DoctorsScreen.routeName);
                                              }
                                            });
                                          },
                                          child: Center(
                                            heightFactor: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8),
                                              child: Text(
                                                "Create connection",
                                                style: TextStyle(
                                                    fontFamily:
                                                        'RobotoCondenced',
                                                    fontSize: 18,
                                                    color: Theme.of(ctx)
                                                        .primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        );
      },
    );
  }
}

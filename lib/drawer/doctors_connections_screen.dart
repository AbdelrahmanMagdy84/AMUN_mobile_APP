import 'package:amun/drawer/doctor_profile_screen.dart';
import 'package:amun/drawer/main_drawer.dart';
import 'package:amun/models/Doctor.dart';
import 'package:amun/models/Responses/DoctorsResponse.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';

class DoctorConnectionScreen extends StatefulWidget {
  static final routeName = 'connection screen';

  @override
  _DoctorConnectionScreenState createState() => _DoctorConnectionScreenState();
}

class _DoctorConnectionScreenState extends State<DoctorConnectionScreen> {
  String medicalFacility_ID;//7ot id el facility hna <---------------------
  @override
  didChangeDependencies() {
    
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
        if (responseList.success) {
          doctorList = responseList.doctors;
          doctorList = doctorList.reversed.toList();
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
                 Text("zxxxxxxxxxxxxxxxxxxxx");
                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      return item(
                          "${doctorList[index].firstName} ${doctorList[index].lastName}",
                          doctorList[index].username,
                          doctorList[index].specialization,
                          doctorList[index],
                          context);
                    },
                    itemCount: doctorList.length,
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
      Doctor myDoctor, BuildContext ctx) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            Navigator.of(ctx).pushNamed(DoctorProfileScreen.routeName,
                arguments: {'doctor': myDoctor});
          },
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * 0.22,
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
                                  ListTile(
                                    title: Card(
                                      elevation: 1,
                                      child: Center(
                                        heightFactor: 2,
                                        child: Text(
                                          "Create connection",
                                          style: TextStyle(
                                              fontFamily: 'RobotoCondenced',
                                              fontSize: 18,
                                              color: Theme.of(ctx).accentColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    onTap: null,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Specialization: $specializationOrRole ',
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 18),
                                      ),
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
                  )),
            ],
          ),
        );
      },
    );
  }
}

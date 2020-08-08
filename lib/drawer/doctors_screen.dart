import 'package:amun/drawer/doctor_profile_screen.dart';
import 'package:amun/drawer/main_drawer.dart';
import 'package:amun/models/Doctor.dart';
import 'package:amun/models/Responses/DoctorsResponse.dart';
import 'package:amun/reminders/ui/success_screen/success_screen.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';

class DoctorsScreen extends StatefulWidget {
  static final routeName = 'Doctors';

  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  String screenTitle;
  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    screenTitle = routeArgs['screen title'];
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

      userFuture = APIClient()
          .getFacilityPatientService()
          .getDoctors(_patientToken)
          .then((DoctorsResponse responseList) {
        if (responseList.success) {
          print("success");
          doctorList = responseList.doctors;
          print(doctorList);
          print(responseList.doctors.length);
        }
      });
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

  Widget buildSearch() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: ListTile(
        leading: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: "search by Username",
            ),
          ),
        ),
        title: IconButton(
          icon: Icon(
            Icons.search,
            size: 34,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            if (screenTitle == "My Doctors")
              Navigator.of(context).pushNamed(DoctorProfileScreen.routeName,
                  arguments: {'userName': usernameController.text});
          },
        ),
      ),
    );
  }

  Widget item(String name, String username, String specializationOrRole,Doctor myDoctor,
      BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        
        Navigator.of(ctx).pushNamed(DoctorProfileScreen.routeName,
            arguments: {'doctor': myDoctor});
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
                                  'Specialization: $specializationOrRole ',
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

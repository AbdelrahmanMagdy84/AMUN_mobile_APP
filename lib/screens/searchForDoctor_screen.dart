import 'package:amun/drawer/doctor_profile_screen.dart';
import 'package:amun/models/Doctor.dart';
import 'package:amun/models/Responses/DoctorResponse.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:flutter/material.dart';

class SearchForDoctorScreen extends StatefulWidget {
  static final String routeName = "search route name";
  @override
  _SearchForDoctorScreenState createState() => _SearchForDoctorScreenState();
}

class _SearchForDoctorScreenState extends State<SearchForDoctorScreen> {
  final usernameController = TextEditingController();
  bool show = false;
  @override
  didChangeDependencies() {
    getUserToken();
    super.didChangeDependencies();
  }

  Doctor searchedDoctor;
  Future userFuture;

  String _patientToken;
  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });
      print(_patientToken);

      userFuture = APIClient()
          .getDoctorService()
          .getDoctor(usernameController.text, _patientToken, "username")
          .then((DoctorResponse response) {
        if (response.success) {
          searchedDoctor = response.doctor;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("search for Doctor")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  //    width: MediaQuery.of(context).size.width * 0.8,
                  child: Expanded(
                    flex: 6,
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "search by Username/email",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 34,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      if (usernameController.text != null) {
                        APIClient()
                            .getDoctorService()
                            .getDoctor(usernameController.text, _patientToken,
                                "username")
                            .then((dynamic response) {
                          if (response.success) {
                            setState(() {
                              searchedDoctor = response.doctor;
                              show = true;
                            });
                          }
                        });
                      } else {
                        setState(() {
                          show = false;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
            show
                ? Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: item("", "", "", new Doctor(), "", context),
                    ))
                : Text('')
          ],
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
                height: MediaQuery.of(context).size.height * 0.4,
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
                                        child: Card(
                                          color: Theme.of(context).accentColor,
                                          elevation: 1,
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

  Widget buildSearch() {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.2,
      child: ListTile(
        leading: Container(
          //    width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: "search by Username/email",
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
            Navigator.of(context).pushNamed(DoctorProfileScreen.routeName,
                arguments: {'userName': usernameController.text});
          },
        ),
      ),
    );
  }
}

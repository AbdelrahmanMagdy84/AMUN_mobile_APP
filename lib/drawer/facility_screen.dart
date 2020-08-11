import 'package:amun/drawer/facility_profile_screen.dart';
import 'package:amun/drawer/main_drawer.dart';
import 'package:amun/models/MedicalFacility.dart';
import 'package:amun/models/Responses/MedicalFacilitiesResponse.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';

import 'package:flutter/material.dart';

class FacilityScreen extends StatefulWidget {
  static final routeName = 'facility route name';

  @override
  _FacilityScreenState createState() => _FacilityScreenState();
}

class _FacilityScreenState extends State<FacilityScreen> {
  String screenTitle;
  final usernameController = TextEditingController();

  List<MedicalFacility> facilityList;
  Future userFuture;
  @override
  didChangeDependencies() {
    getUserToken();
    super.didChangeDependencies();
  }

  String _patientToken;
  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });
      userFuture = APIClient()
          .getFacilityPatientService()
          .getMedicalFacilities(_patientToken)
          .then((MedicalFacilitiesResponse responseList) {
        if (responseList.success) {
          facilityList = responseList.medicalFacilities;
          facilityList = facilityList.reversed.toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facilities"),
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
                  return facilityList == null
                      ? Center(child: Text("no facilities"))
                      : ListView.builder(
                          itemBuilder: (ctx, index) {
                            return item(
                                facilityList[index].name,
                                facilityList[index].username,
                                facilityList[index].description,
                                facilityList[index],
                                context);
                          },
                          itemCount: facilityList.length,
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
            Navigator.of(context).pushNamed(FacilityScreen.routeName,
                arguments: {'userName': usernameController.text});
          },
        ),
      ),
    );
  }
}

Widget item(String name, String username, String type,
    MedicalFacility myfacility, BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          print(FacilityScreen.routeName);
          Navigator.of(context).pushNamed(FacilityProfileScreen.routeName,
              arguments: {'facility': myfacility});
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
                                    'Name: $name',
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
                                Expanded(
                                  child: Container(
                                    // padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'type: $type ',
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

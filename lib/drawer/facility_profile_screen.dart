import 'package:amun/models/Doctor.dart';
import 'package:amun/models/MedicalFacility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FacilityProfileScreen extends StatefulWidget {
  static final String routeName = "facility profile route name";
  @override
  _FacilityProfileScreenState createState() => _FacilityProfileScreenState();
}

class _FacilityProfileScreenState extends State<FacilityProfileScreen> {
  //String userName; //required
  MedicalFacility facility;
  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    facility = routeArgs['facility'];
    super.didChangeDependencies();
  }
/**get doctor by username */
  // @override
  // void initState() {
  //   super.initState();
  //   print("getting user token");
  //   getUserToken();
  // }

  // void getUserToken() {
  //   TokenStorage().getUserToken().then((value) async {
  //     setState(() {
  //       _patientToken = value;
  //     });
  //     userFuture = APIClient()
  //         .getDoctorService()
  //         .getDoctorByUsername(_patientToken, userName)
  //         .then((DoctorResponse doctorResponse) {
  //       if (doctorResponse.success) {
  //         doctor = doctorResponse.doctor;
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facility: ${facility.name}"),
      ),
      body: buildItem(),
    );
  }

  Widget buildItem() {
    const double h = 50;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Container(
                //height: mediaQuery.height * 0.25,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Divider(
                      height: h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: EdgeInsets.only(top: 15, left: 15),
                          child:
                              buildMyText(context, "Name", "${facility.name}")),
                    ),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: buildMyText(
                            context, "Username", facility.username)),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: buildMyText(context, "Email", facility.email)),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child: buildMyText(
                            context, "Description", facility.description)),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child: buildMyText(context, "Mobile", facility.mobile)),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child: buildMyText(context, "Type", facility.type)),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child:
                            buildMyText(context, "Address", facility.address)),
                    Divider(
                      height: h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMyText(BuildContext ctx, String title, String value) {
    return Container(
        child: Row(
      children: <Widget>[
        Text("$title: ",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Theme.of(ctx).accentColor)),
        Flexible(
          child: Container(
            child: Text("$value",
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 16,
                )),
          ),
        ),
      ],
    ));
  }
}

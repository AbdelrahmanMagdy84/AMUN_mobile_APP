import 'package:amun/models/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorProfileScreen extends StatefulWidget {
  static final String routeName = "Doctor Profile route name";
  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  String userName;
  Doctor doctor;
  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    doctor = routeArgs['doctor'];
    super.didChangeDependencies();
  }

  /* @override
  void initState() {
    super.initState();
    print("getting user token");
    getUserToken();
  }

  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });
      print(_patientToken);
      userFuture = APIClient()
          .getDoctorService()
          .getDoctorByUsername(userName, _patientToken)
          .then((DoctorResponse doctorResponse) {
        if (doctorResponse.success) {
          doctor = doctorResponse.doctor;
          print("doctor");
        }
      });
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor: ${doctor.firstName}"),
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
                          child: buildMyText(context, "Full Name",
                              "${doctor.firstName} ${doctor.lastName}")),
                    ),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child:
                            buildMyText(context, "Username", doctor.username)),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: buildMyText(context, "Email", doctor.email)),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child: buildMyText(context, "Bio", doctor.bio)),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child: buildMyText(context, "Mobile", doctor.mobile)),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child: buildMyText(context, "Gender", doctor.gender)),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child: buildMyText(context, "Birth Date:",
                            DateFormat.yMd().format(doctor.birthDate))),
                    Divider(
                      height: h,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child: buildMyText(
                            context, "Specialization:", doctor.specialization)),
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

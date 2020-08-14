import 'package:amun/models/Doctor.dart';
import 'package:amun/models/MedicalFacility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
    Future<void> _launched;
    const double h = 40;
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
            ),
            Row(
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.email,
                      color: Colors.redAccent,
                    ),
                      onPressed: () => setState(() {
                      _launched = _createEmail(facility.email);
                    }),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.call,
                      color: Colors.green,
                    ),
                    onPressed: () => setState(() {
                      _launched = _makePhoneCall('tel:${facility.mobile}');
                    }),
                  ),
                ),
                FutureBuilder<void>(future: _launched, builder: _launchStatus),
              ],
            )
          ],
        ),
      ),
    );
  }

Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }
  Future<void> _createEmail(String email) async {
    if (await canLaunch("mailto:$email?subject=Amun MR")) {
      await launch("mailto:$email?subject=Amun MR");
    } else {
      throw 'Could not Email';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static final String routeName = "Profile route name";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profileType;
  String firstName = "Abdelrahman ";
  String lastName = " Magdy";
  String email = "boody8@gmail.com";
  String username = "abdelrahman84";
  String role = "نسا و توليد";
  String mobile = "01110207908";
  String gender = "male";

  @override
  Widget build(BuildContext context) {
    const double h = 50;
    return Scaffold(
        appBar: AppBar(
          title: Text("profile: $profileType"),
        ),
        body: Center(
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
                                  "$firstName $lastName")),
                        ),
                        Divider(
                          height: h,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 15),
                            alignment: Alignment.centerLeft,
                            child: buildMyText(context, "Username", username)),
                        Divider(
                          height: h,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 15),
                            alignment: Alignment.centerLeft,
                            child: buildMyText(context, "Email", email)),
                        Divider(
                          height: h,
                        ),
                        Container(
                            margin: EdgeInsets.only(
                              left: 15,
                            ),
                            alignment: Alignment.centerLeft,
                            child: buildMyText(context, "Role", role)),
                        Divider(
                          height: h,
                        ),
                        Container(
                            margin: EdgeInsets.only(
                              left: 15,
                            ),
                            alignment: Alignment.centerLeft,
                            child: buildMyText(context, "Mobile", mobile)),
                        Divider(
                          height: h,
                        ),
                        Container(
                            margin: EdgeInsets.only(
                              left: 15,
                            ),
                            alignment: Alignment.centerLeft,
                            child: buildMyText(context, "Gender", gender)),
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
        ));
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

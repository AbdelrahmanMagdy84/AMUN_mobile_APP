import 'package:amun/services/APIClient.dart';
import 'package:amun/models/Responses/PatientResponse.dart';
import '../screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'categories_screen.dart';
import '../input_widgets/DialogManager.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login_register';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Widget buildTextField(String title, TextEditingController controller,
      TextInputType textInputType) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: TextField(
        decoration: InputDecoration(
          labelText: "$title",
        ),
        controller: controller,
        keyboardType: textInputType,
      ),
    );
  }

  void login() {
    DialogManager.showLoadingDialog(context);
    APIClient()
        .getPatientService()
        .login(_usernameController.text, _passwordController.text)
        .then((PatientResponse patientResponse) {
      if (patientResponse.success) {
        print(patientResponse.patient.pid);
        print("User Logged in!");
        DialogManager.stopLoadingDialog(context);
        Navigator.of(context).pushReplacementNamed(CategoriesScreen.routeName);
        /*LocalStorage().saveUser(patientResponse.patient).then((_) {
          Navigator.pushReplacementNamed(context, "/home");
        });*/
      }
    }).catchError((Object e) {
      DialogManager.stopLoadingDialog(context);
      DialogManager.showErrorDialog(context, "Wrong email/password");
      print(e.toString());
    });
  }

  void createNewAcount(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed(RegisterScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Divider(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            buildTextField(
              'Username',
              _usernameController,
              TextInputType.text,
            ),
            buildTextField(
              'Password',
              _passwordController,
              TextInputType.text,
            ),
            Container(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: FlatButton(
                  onPressed: () => login(),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                )),
            Container(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: FlatButton(
                  onPressed: () => createNewAcount(context),
                  child: Text(
                    'Create New Profile',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

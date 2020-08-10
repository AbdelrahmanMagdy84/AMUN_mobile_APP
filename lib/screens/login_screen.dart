import 'package:amun/services/APIClient.dart';
import 'package:amun/models/Responses/PatientResponse.dart';
import '../screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'categories_screen.dart';
import '../input_widgets/DialogManager.dart';
import '../utils/TokenStorage.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login_register';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
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
        print("User Logged in!");
        DialogManager.stopLoadingDialog(context);
        TokenStorage().saveUserToken(patientResponse.token).then((_) {
          Navigator.of(context)
              .pushReplacementNamed(CategoriesScreen.routeName);
        });
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

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: _toggle,
                      child: new Text(_obscureText ? "Show" : "Hide")),
                ),
              ],
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

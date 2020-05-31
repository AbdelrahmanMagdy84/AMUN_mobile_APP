import '../screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'categories_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'login_register';

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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

  void login(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed(CategoriesScreen.routeName);
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
            Divider(height: MediaQuery.of(context).size.height*0.15,),
            buildTextField(
              'Username',
              usernameController,
              TextInputType.text,
            ),
            buildTextField(
              'Password',
              passwordController,
              TextInputType.text,
            ),
            Container(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: FlatButton(
                  onPressed: () => login(context),
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

import '../screens/category_records_screen.dart';
import '../models/patient.dart';
import '../screens/categories_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static final String routeName = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Patient patient = new Patient();
  Gender gender = Gender.Male;
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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

  Widget buildGenderRadiolistTile() {
    return Card(
        child: Column(children: <Widget>[
      Text('Gender', style: TextStyle(fontSize: 20)),
      RadioListTile(
          title: Text('Male'),
          value: Gender.Male,
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          }),
      RadioListTile(
          title: Text(
            'Female',
          ),
          value: Gender.Female,
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          })
    ]));
  }

  void register(BuildContext ctx) {
    patient.name = nameController.toString();
    patient.username = usernameController.toString();
    patient.email = emailController.toString();
   // patient.phone =int.parse(phoneController as String );
    patient.password = phoneController.toString();
    // patient.dateOfBirth = dateOfBirthController.toString() as DateTime;

    Navigator.of(ctx).pushNamed(CategoriesScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildTextField(
              'Name',
              nameController,
              TextInputType.text,
            ),
            buildTextField(
              'Username',
              usernameController,
              TextInputType.text,
            ),
            buildTextField(
              'Date of birth',
              dateOfBirthController,
              TextInputType.datetime,
            ),
            buildTextField(
              'Email',
              emailController,
              TextInputType.emailAddress,
            ),
            buildTextField(
              'Phone',
              phoneController,
              TextInputType.phone,
            ),
            buildTextField(
              'Password',
              passwordController,
              TextInputType.visiblePassword,
            ),
            buildTextField(
              'Confirm Password',
              confirmPasswordController,
              TextInputType.visiblePassword,
            ),
            buildGenderRadiolistTile(),
            Container(
                padding: EdgeInsets.all(15),
                child: FlatButton(
                  onPressed: () => register(context),
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 24,
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

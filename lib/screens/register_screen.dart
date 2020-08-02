import 'package:dropdown_search/dropdown_search.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:intl/intl.dart';
import '../models/patient.dart';
import '../screens/categories_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static final String routeName = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _autoValidate = false;
  Patient patient = new Patient();
  final DateTime initialDateTime = DateTime.now();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String _name;
  String _username;
  DateTime _dateOfBirth;
  String _email;
  String _phone;
  String _password;
  String _confirmPassword;
  String selectedBloodtype;
  Gender gender = Gender.Male;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);
  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  void register(BuildContext ctx, var formkey) {
    if (formkey.currentState.validate()) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
//    If all data are correct then save data to out variables
        patient.name = _name;
        patient.username = _username;
        patient.email = _email;
        patient.phone = _phone;
        patient.password = _password;
        patient.dateOfBirth = DateFormat.yMMMd().format(_dateOfBirth);
        patient.gender = gender;
        patient.bloodType = selectedBloodtype;
      } else {
//    If all data are not valid then start auto validation.
        setState(() {
          _autoValidate = true;
        });
      }
    }
    Navigator.of(ctx).pushReplacementNamed(CategoriesScreen.routeName);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Form(
        autovalidate: _autoValidate,
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildTextField(
                  title: 'Name',
                  controller: nameController,
                  textInputType: TextInputType.text,
                  myValue: _name,
                  validator: (String arg) {
                    if (arg.length < 3)
                      return 'Name must be more than 2 charater';
                    else
                      return null;
                  },
                ),
                buildTextField(
                  myValue: _username,
                  title: 'Username',
                  controller: usernameController,
                  textInputType: TextInputType.text,
                  validator: (String arg) {
                    if (arg.length < 3)
                      return 'Username must be more than 2 charater';
                    else
                      return null;
                  },
                ),
                Padding(padding: EdgeInsets.only(top:10),),
                DateTimeFormField(
                  onlyDate: true,
                  initialValue: initialDateTime,
                  label: "Date of Birth",
                  validator: (DateTime dateTime) {
                    if (dateTime == null) {
                      return "Date of Birth";
                    }
                    return null;
                  },
                  onSaved: (DateTime dateTime) => _dateOfBirth = dateTime,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: buildTextField(
                          title: 'Phone',
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          validator: validateMobile,
                        ),
                      ),
                      Expanded(flex: 3, child: buildDropDownSearch()),
                    ],
                  ),
                ),
                buildTextField(
                  myValue: _email,
                  title: 'Email',
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                buildTextField(
                  myValue: _password,
                  title: 'Password',
                  controller: passwordController,
                  textInputType: TextInputType.visiblePassword,
                  validator: passwordValidator,
                ),
                buildTextField(
                  myValue: _confirmPassword,
                  title: 'Confirm Password',
                  controller: confirmPasswordController,
                  textInputType: TextInputType.visiblePassword,
                  validator: (val) =>
                      MatchValidator(errorText: 'passwords do not match')
                          .validateMatch(val, passwordController.text),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: buildGenderRadiolistTile()),
                Container(
                    padding: EdgeInsets.all(15),
                    child: FlatButton(
                      onPressed: () => register(context, _formKey),
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
        ),
      ),
    );
  }
    Widget buildDropDownSearch() {
    List<String> bloodTyps = [
      "      O-",
      "      O+",
      "      A-",
      "      A+",
      "      B-",
      "      B+",
      "      AB-",
      "      AB+"
    ];
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: <Widget>[
          DropdownSearch<String>(
            maxHeight: 150,

            selectedItem: selectedBloodtype,
            //showSearchBox: true,
            mode: Mode.MENU,
            showSelectedItem: true,
            items: bloodTyps,
            label: "Blood Type",
            hint: 'choose',
            //popupItemDisabled: (String s) => s.endsWith(':'),
            onChanged: (bloodType) {
              selectedBloodtype = bloodType;
            },
            //selectedItem: "Brazil"
          )
        ],
      ),
    );
  }

  Widget buildGenderRadiolistTile() {
    return Card(
        child: Column(children: <Widget>[
      Text('Gender', style: TextStyle(fontSize: 16)),
      Container(
        child: RadioListTile(
            title: Text('Male'),
            value: Gender.Male,
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value;
              });
            }),
      ),
      Container(
        child: RadioListTile(
            title: Text(
              'Female',
            ),
            value: Gender.Female,
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value;
              });
            }),
      )
    ]));
  }

  Widget buildTextField(
      {String title,
      TextEditingController controller,
      TextInputType textInputType,
      Function validator,
      var myValue}) {
    return Container(
      child: TextFormField(
          decoration: InputDecoration(
            labelText: "$title",
          ),
          //controller: controller,
          keyboardType: textInputType,
          validator: validator,
          onSaved: (String value) {
            myValue = value;
            //controller = value as TextEditingController;
          }),
    );
  }

}

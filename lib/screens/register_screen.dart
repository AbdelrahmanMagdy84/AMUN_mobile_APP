import 'package:dropdown_search/dropdown_search.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';

import 'package:amun/models/Responses/PatientResponse.dart';
import 'package:amun/services/APIClient.dart';
import '../models/Patient.dart';
import 'package:flutter/material.dart';
import '../input_widgets/DialogManager.dart';

class RegisterScreen extends StatefulWidget {
  static final String routeName = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _autoValidate = false;

  final DateTime initialDateTime = DateTime.now();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  DateTime _dateOfBirth;
  String selectedBloodtype;
  String gender;

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
    if (value.length != 11)
      return 'Mobile Number must be of 11 digit';
    else
      return null;
  }

  void register(var formkey) {
    DialogManager.showLoadingDialog(context);
    if (formkey.currentState.validate()) {
      print("signing up");
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        Patient patient = new Patient(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            username: usernameController.text,
            email: emailController.text,
            mobile: phoneController.text,
            password: passwordController.text,
            birthDate: _dateOfBirth,
            gender: gender,
            bloodType: selectedBloodtype,
            allergies: [],
            medications: [],
            conditions: []);
        APIClient()
            .getPatientService()
            .signup(patient)
            .then((PatientResponse patientResponse) {
          if (patientResponse.success) {
            DialogManager.stopLoadingDialog(context);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          }
        }).catchError((Object e) {
          DialogManager.stopLoadingDialog(context);
          print(e.toString());
        });
      } else {
//    If all data are not valid then start auto validation.
        setState(() {
          _autoValidate = true;
        });
      }
    }
    //Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: buildTextField(
                          title: 'First Name',
                          controller: firstNameController,
                          textInputType: TextInputType.text,
                          validator: (String arg) {
                            if (arg.length < 3)
                              return 'Name must be more than 2 charater';
                            else
                              return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: buildTextField(
                          title: 'Last Name',
                          controller: lastNameController,
                          textInputType: TextInputType.text,
                          validator: (String arg) {
                            if (arg.length < 3)
                              return 'Name must be more than 2 charater';
                            else
                              return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                buildTextField(
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
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                DateTimeFormField(
                  onlyDate: true,
                  initialValue: initialDateTime,
                  label: "Birth Date",
                  validator: (DateTime dateTime) {
                    if (dateTime == null) {
                      return "Birth Date is required";
                    }
                    return null;
                  },
                  onSaved: (DateTime dateTime) => _dateOfBirth = dateTime,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
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
                  title: 'Email',
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                buildTextField(
                  title: 'Password',
                  controller: passwordController,
                  textInputType: TextInputType.visiblePassword,
                  validator: passwordValidator,
                ),
                buildTextField(
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
                      onPressed: () => register(_formKey),
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
    List<String> bloodTyps = ["O-", "O+", "A-", "A+", "B-", "B+", "AB-", "AB+"];
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Container(
        color: Theme.of(context).primaryColor.withOpacity(0.7),
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
      ),
    );
  }

  Widget buildGenderRadiolistTile() {
    return Card(
        child: Container(
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Gender', style: TextStyle(fontSize: 18)),
        ),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: RadioListTile(
                  title: Text('Male'),
                  value: "male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  }),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: RadioListTile(
                  title: Text(
                    'Female',
                  ),
                  value: "female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  }),
            )
          ],
        )
      ]),
    ));
  }

  Widget buildTextField(
      {String title,
      TextEditingController controller,
      TextInputType textInputType,
      Function validator}) {
    return Container(
      child: TextFormField(
          maxLength: 20,
          decoration: InputDecoration(
            labelText: "$title",
          ),
          controller: controller,
          keyboardType: textInputType,
          validator: validator),
    );
  }
}

import 'package:amun/drawer/main_drawer.dart';
import 'package:amun/input_widgets/DialogManager.dart';
import 'package:amun/models/Responses/PatientResponse.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import '../models/Patient.dart';

class EditPatientInfo extends StatefulWidget {
  static final String routeName = "edt info route";
  @override
  _EditPatientInfoState createState() => _EditPatientInfoState();
}

class _EditPatientInfoState extends State<EditPatientInfo> {
  Patient patient;
  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    setState(() {
      if (routeArgs != null) {
        patient = routeArgs['information'];
      }
    });
    super.didChangeDependencies();
  }

  final _newPasswordConroller = TextEditingController();

  DateTime newBirthDate = DateTime.now();
  String gender;
  String bloodType;

  String _patientToken;
  @override
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
    });
  }

  void updatePatient() {
    Patient newpatient;
    newpatient.password = _newPasswordConroller.text;
    newpatient.birthDate = newBirthDate;
    newpatient.bloodType = bloodType;
    DialogManager.showLoadingDialog(context);
    APIClient()
        .getPatientService()
        .updatePatient(newpatient, _patientToken)
        .then((PatientResponse patientResponse) {
      if (patientResponse.success) {
        DialogManager.stopLoadingDialog(context);
        Navigator.of(context).pop();
      }
    }).catchError((Object e) {
      DialogManager.stopLoadingDialog(context);
      DialogManager.showErrorDialog(context, "Couldn't Edit");
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    bloodType = patient.bloodType;
    return Scaffold(
      appBar: AppBar(title: Text("Edit information")),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                            top: 40,
                          ),
                          child: Text(
                            "Password: ${patient.password}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: buildTextField(
                          title: 'new password',
                          controller: _newPasswordConroller,
                          textInputType: TextInputType.visiblePassword,
                          validator: passwordValidator,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          top: 40,
                        ),
                        child: Text(
                            "Birth Date:  ${DateFormat.yMd().format(patient.birthDate)}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 70),
                        child: DateTimeFormField(
                          formatter: DateFormat.yMd(),
                          onlyDate: true,
                          initialValue: patient.birthDate,
                          label: "Birth Date",
                          onSaved: (DateTime dateTime) =>
                              newBirthDate = dateTime,
                          validator: (DateTime dateTime) {
                            if (dateTime == null) {
                              return "Birth Date is required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: buildDropDownSearch(),
            ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                child: FlatButton(
                  onPressed: () {
                    updatePatient();
                  },
                  child: Text(
                    'Save Changes',
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

  Widget buildTextField(
      {String title,
      TextEditingController controller,
      TextInputType textInputType,
      Function validator}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: TextField(
        decoration: InputDecoration(
          labelText: "$title",
        ),
        controller: controller,
        keyboardType: textInputType,
        onChanged: validator,
      ),
    );
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);
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
      child: Container(
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        child: DropdownSearch<String>(
          maxHeight: 150,
          selectedItem: bloodType,
          mode: Mode.MENU,
          showSelectedItem: true,
          items: bloodTyps,
          label: "Blood Type",
          hint: bloodType == null
              ? 'no blood type choosen yet'
              : 'current value: $bloodType',
          //popupItemDisabled: (String s) => s.endsWith(':'),
          onChanged: (bloodType) {
            bloodType = bloodType;
          },
          //selectedItem: "Brazil"
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
                  value: 'male',
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
}

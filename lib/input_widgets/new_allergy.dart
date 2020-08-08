import 'package:amun/drawer/allergies_screen.dart';
import 'package:amun/input_widgets/DialogManager.dart';
import 'package:amun/models/Responses/PatientResponse.dart';
import 'package:amun/screens/categories_screen.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../static_data/allergy_data.dart';
import 'package:flutter/material.dart';

class NewAllergy extends StatefulWidget {
  final List<String> oldAllergies;
  NewAllergy(this.oldAllergies);
  @override
  _NewAllergyState createState() => _NewAllergyState();
}

class _NewAllergyState extends State<NewAllergy> {
  String selectedAllergy;
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

  void updatePatient(List<String> newAllergy) {
   
    //  Patient newpatient = Patient(allergies: updatedAllergies);
    DialogManager.showLoadingDialog(context);
   
    APIClient()
        .getPatientService()
        .updatePatientList(newAllergy, "allergies", _patientToken)
        .then((PatientResponse patientResponse) {
      if (patientResponse.success) {
     
        DialogManager.stopLoadingDialog(context);
       // Navigator.of(context).pop();
      }
    }).catchError((Object e) {
      DialogManager.stopLoadingDialog(context);
      DialogManager.showErrorDialog(context, "Couldn't Edit");
      print(e.toString());
    });
  }

  void saveNewAllergy(String selectedAllergy) {
    selectedAllergy = selectedAllergy.substring(8);
    print(selectedAllergy);
    List<String> newAllergies = widget.oldAllergies;
    newAllergies.add(selectedAllergy);
    updatePatient(newAllergies);

     Navigator.pushNamedAndRemoveUntil(
         context, CategoriesScreen.routeName, (r) => false);
     Navigator.pushNamed(context, AllergiesScreen.routeName,
         arguments: {'allergies': newAllergies});
  }

  @override
  Widget build(BuildContext context) {
    createAllergiesList();
    return SingleChildScrollView(
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                child: Text(
                  'Allergies',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(),
            buildDropDownSearch(allergies),
            Container(
              margin: EdgeInsets.all(30),
              child: FlatButton(
                onPressed: () => saveNewAllergy(selectedAllergy),
                color: Theme.of(context).accentColor,
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  Widget buildDropDownSearch(List<String> items) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 50),
      child: Column(
        children: <Widget>[
          DropdownSearch<String>(
            maxHeight: 250,
            selectedItem: selectedAllergy,
            //showSearchBox: true,
            mode: Mode.MENU,
            showSelectedItem: true,
            items: items,
            label: 'Allergies',
            hint: 'Choose your Allergy',
            popupItemDisabled: (String s) => s.endsWith(':'),
            onChanged: (allergy) {
              selectedAllergy = allergy;
            },
            //selectedItem: "Brazil"
          )
        ],
      ),
    );
  }
}
// String selectAllergyCategory() {
//     String category;
//     if (respiratoryAllergies.contains(selectedAllergy)) {
//       category = "Respiratory Allergy";
//     } else if (foodAllergies.contains(selectedAllergy)) {
//       category = "food Allergy";
//     } else if (skinAllergies.contains(selectedAllergy)) {
//       category = "Skin Allergy";
//     } else {
//       category = "other Allergy";
//     }
//     return category;
//   }

import 'package:amun/drawer/allergies_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../static_data/allergy_data.dart';
import 'package:flutter/material.dart';

class NewAllergy extends StatefulWidget {
  @override
  _NewAllergyState createState() => _NewAllergyState();
}

class _NewAllergyState extends State<NewAllergy> {
  String selectedAllergy;
  String selectedCategory;

  Widget buildDropDownSearch(List<String> items, String title) {
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
            label: title,
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

  void saveNewAllergy(String selectedAllergy, String selectedCategory) {
    selectedCategory = selectAllergyCategory();
    selectedAllergy = selectedAllergy.substring(8);
    Navigator.pop(context);
    Navigator.of(context)
        .pushReplacementNamed(AllergiesScreen.routeName, arguments: {
      'allergy': selectedAllergy,
      'type': selectedCategory,
    });
  }

  String selectAllergyCategory() {
    String category;
    if (respiratoryAllergies.contains(selectedAllergy)) {
      category = "Respiratory Allergy";
    } else if (foodAllergies.contains(selectedAllergy)) {
      category = "food Allergy";
    } else if (skinAllergies.contains(selectedAllergy)) {
      category = "Skin Allergy";
    } else {
      category = "other Allergy";
    }
    return category;
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
            buildDropDownSearch(allergies, 'Allergies'),
            Container(
              margin: EdgeInsets.all(30),
              child: FlatButton(
                onPressed: () =>
                    saveNewAllergy(selectedAllergy, selectedCategory),
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
}

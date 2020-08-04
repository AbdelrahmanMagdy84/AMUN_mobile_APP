import 'package:amun/drawer/allergies_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import '../static_data/allergy_data.dart';
import 'package:flutter/material.dart';

class NewAllergy extends StatefulWidget {
  @override
  _NewAllergyState createState() => _NewAllergyState();
}

class _NewAllergyState extends State<NewAllergy> {
  DateTime date;
  String selectedAllergy;
  String selectedCategory;

  Widget buildDropDownSearch(List<String> items, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
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

  void displayDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null)
        return;
      else
        setState(() {
          date = pickedDate;
        });
    });
  }

  void saveNewAllergy(
      String selectedAllergy, DateTime date, String selectedCategory) {
    selectedCategory = selectAllergyCategory();
    selectedAllergy = selectedAllergy.substring(8);
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(AllergiesScreen.routeName,
        arguments: {
          'allergy': selectedAllergy,
          'type': selectedCategory,
          'date': date
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
              padding: const EdgeInsets.only(top:15),
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
            Padding(
              padding:
                  EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 40),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      date == null
                          ? 'No date chosen'
                          : 'Picked Date: ${DateFormat.yMd().format(date)}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: displayDatePicker,
                    child: Icon(
                      Icons.date_range,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: FlatButton(
                onPressed: () =>
                    saveNewAllergy(selectedAllergy, date, selectedCategory),
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

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPrescreptionOrRadiograph extends StatefulWidget {
  final String title;
  NewPrescreptionOrRadiograph(this.title);

  @override
  _NewPrescreptionOrRadiographState createState() =>
      _NewPrescreptionOrRadiographState();
}

class _NewPrescreptionOrRadiographState
    extends State<NewPrescreptionOrRadiograph> {
  final presTitleController = TextEditingController();
  final facilityNameController = TextEditingController();
  final doctorNameController = TextEditingController();
  final clerkNameController = TextEditingController();
  final noteController = TextEditingController();

  Widget buildTextField(String title, TextEditingController controller,
      TextInputType textInputType) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: TextField(
        decoration: InputDecoration(
          labelText: "$title:",
        ),
        controller: controller,
        keyboardType: textInputType,
      ),
    );
  }

  File _imageFile;

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _imageFile = picture;
    });
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      _imageFile = picture;
    });
  }

  Widget setImageView() {
    if (_imageFile != null) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        margin: EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Image.file(
            _imageFile,
            width: double.infinity,
            height: 200,
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      return Container(
        child: Text("Please select an image"),
        padding: EdgeInsets.only(top: 15, bottom: 10),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Center(
                  child: Text(
                    "Add New ${widget.title}",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Divider(),
              buildTextField(
                'Title',
                presTitleController,
                TextInputType.text,
              ),
              Divider(),
              buildTextField(
                'Facility',
                facilityNameController,
                TextInputType.text,
              ),
              buildTextField(
                'Doctor',
                doctorNameController,
                TextInputType.text,
              ),
              buildTextField(
                'Clerk',
                clerkNameController,
                TextInputType.text,
              ),
              buildTextField(
                'Note',
                noteController,
                TextInputType.text,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.image,
                          color: Theme.of(context).primaryColor),
                      onPressed: () => _openGallery(context),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => _openCamera(context),
                    ),
                  ),
                ],
              ),
              setImageView(),
              FlatButton(
                  padding: EdgeInsets.all(30),
                  onPressed: null,
                  color: Theme.of(context).accentColor,
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

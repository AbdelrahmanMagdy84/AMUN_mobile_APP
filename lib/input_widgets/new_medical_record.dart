import 'dart:io';
import 'package:amun/models/MedicalRecord.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewMedicalRecord extends StatefulWidget {
  final String title;
  NewMedicalRecord(this.title);

  @override
  _NewPrescreptionOrRadiographState createState() =>
      _NewPrescreptionOrRadiographState();
}

class _NewPrescreptionOrRadiographState extends State<NewMedicalRecord> {
  DateTime dateTime = DateTime.now();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  DateTime date;
  File _imageFile;
  //File file;

  void save(
      {DateTime date, String title, String doctor, String note, String image}) {
    MedicalRecord medicalRecord =
        MedicalRecord(date: date, title: title, id: "1", note: note);
  }

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          autovalidate: _autoValidate,
          key: _formKey,
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
                    'Title', titleController, TextInputType.text, 40),
                buildTextField('Note', noteController, TextInputType.text, 130),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          date == null
                              ? 'No date chosen'
                              : 'Picked Date: ${DateFormat.yMd().format(date)}',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Expanded(
                        child: FloatingActionButton(
                          onPressed: displayDatePicker,
                          child: Icon(
                            Icons.date_range,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
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
                Container(
                  margin: EdgeInsets.all(30),
                  child: FlatButton(
                    onPressed: save,
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
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String title, TextEditingController controller,
      TextInputType textInputType, int length) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: TextField(
        decoration: InputDecoration(
          labelText: "$title:",
        ),
        controller: controller,
        keyboardType: textInputType,
        maxLength: length,
      ),
    );
  }

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
}
// Divider(),
// buildTextField(
//   'Facility',
//   facilityNameController,
//   TextInputType.text,
// ),
// buildTextField(
//   'Doctor',
//   doctorNameController,
//   TextInputType.text,
// ),
// buildTextField(
//   'Clerk',
//   clerkNameController,
//   TextInputType.text,
// ),
// Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: IconButton(
//                         icon: Icon(
//                           Icons.picture_as_pdf,
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         onPressed: () async {
//                           file = await FilePicker.getFile(
//                             type: FileType.custom,
//                             allowedExtensions: ['pdf', 'doc', 'png', 'jpg'],
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//** */
// FutureBuilder(
//                   future: FilePicker.getFile(
//                     type: FileType.custom,
//                     allowedExtensions: ['pdf', 'doc', 'png', 'jpg'],
//                   ),
//                   builder: (ctx, snapshot) {
//                     switch (snapshot.connectionState) {
//                       case ConnectionState.none:
//                         return Text("none");
//                         break;
//                       case ConnectionState.active:
//                       case ConnectionState.waiting:
//                         return Center(
//                             child: Text(
//                           "Loading ",
//                           style: Theme.of(context).textTheme.title,
//                         ));
//                         break;
//                       case ConnectionState.done:
//                         String path = snapshot.data;
//                         if (path != null && path.endsWith('g')) {
//                           setImageView();
//                         } else {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Card(
//                               child: Text("file: ${snapshot.data.toString()}"),
//                             ),
//                           );
//                         }
//                         break;
//                     }
//                   },
//                 ),

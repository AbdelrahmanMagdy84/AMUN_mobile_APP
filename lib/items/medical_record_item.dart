import 'package:amun/screens/show_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class MedicalRecordItem extends StatefulWidget {
  @override
  _MedicalRecordItemState createState() => _MedicalRecordItemState();
}

class _MedicalRecordItemState extends State<MedicalRecordItem> {
  String text = '';
  String subject = '';

  @override
  Widget build(BuildContext context) {
    String image = 'assets/images/pres.png';
    String facility = "Elorman";
    String title = "Dental Prescrption";
    String doctor = "Ahmed Abdelaziz";
    String clerk = "soliman Eid";
    String note =
        "Resources are limited to 1000 pounds of special plastic 40 hours of production time per week Resources are limited to 1000 pounds of special plastic 40 hours of production time per week ";
    DateTime date = DateTime.now();

    return Container(
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: FittedBox(
                      child: Text(
                "Title: $title",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ))),
              Divider(),
              FittedBox(child: Text("Facility: $facility")),
              Divider(),
              FittedBox(child: Text("Doctor: DR.$doctor")),
              Divider(),
              FittedBox(child: Text("Clerk: $clerk")),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(ShowImageScreen.routeName, arguments: {
                      'image': image,
                    }),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.asset(
                          image,
                          fit: BoxFit.fitWidth,
                          height: 100,
                          width: 80,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 230,
                    child: Text(
                      "Note: $note",
                      maxLines: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Builder(builder: (BuildContext context) {
                      return IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: image.isEmpty
                              ? null
                              : () async {
                                  try {
                                    final ByteData bytes = await rootBundle
                                        .load('$image');
                                    await Share.file('esys image', 'esys.png',
                                        bytes.buffer.asUint8List(), 'image/png',
                                        text: 'My optional text.');
                                  } catch (e) {
                                    print('error: $e');
                                  }
                                }
                          // widget.delete(widget.transaction.id),
                          );
                    }),
                  ),
                  Divider(),
                  Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () {}
                        // widget.delete(widget.transaction.id),
                        ),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () {}
                        // widget.delete(widget.transaction.id),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: <Widget>[
                        Text(DateFormat.Hm().format(date)),
                        Text(DateFormat.yMMMd().format(date)),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

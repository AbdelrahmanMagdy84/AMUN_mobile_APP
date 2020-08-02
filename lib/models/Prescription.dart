
//import 'package:sqflite/sqflite.dart';

class Prescription {
  int id;
  DateTime date;
  String title;
  String doctor;
  String image;
  String note;

  Prescription({this.id, this.title, this.doctor, this.date, this.image,this.note});
 }

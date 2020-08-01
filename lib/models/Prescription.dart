// import 'package:amun/db/database_provider.dart';
// //import 'package:sqflite/sqflite.dart';

// class Prescription {
//   int id;
//   DateTime date;
//   String title;
//   String doctor;
//   String image;
//   String note;

//   Prescription({this.id, this.title, this.doctor, this.date, this.image,this.note});
//   Map<String, dynamic> toMap() {
//     var map = <String, dynamic>{
//       DatabaseProvider.column_Id: id.toString(),
//       DatabaseProvider.column_title: title,
//       DatabaseProvider.column_image: image,
//       DatabaseProvider.column_date:date,
//       DatabaseProvider.column_doctorName:doctor,
//       DatabaseProvider.column_note:note
//     };
//     if(id!=null)
//     {
//       map[DatabaseProvider.column_Id]=id.toString();
       
//     }
//   }

//   Prescription.fromMap(Map<String,dynamic>map){
//     id=map[DatabaseProvider.column_Id];
//     title=map[DatabaseProvider.column_title];
//     doctor=map[DatabaseProvider.column_doctorName];
//     image=map[DatabaseProvider.column_image];
//     date=map[DatabaseProvider.column_date];
//      note=map[DatabaseProvider.column_note];
//   }
// }

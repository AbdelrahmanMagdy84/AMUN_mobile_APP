import 'Clerk.dart';
import 'Doctor.dart';
import 'MedicalFacility.dart';

class MedicalRecord {
  String id;
  DateTime date;
  String title;
  String note;
  String enteredBy;
  String type;
  MedicalFile report;
  MedicalFile radiograph;
  MedicalFile prescription;
  Clerk clerk;
  Doctor doctor;
  MedicalFacility medicalFacility;
  MedicalRecord(
      {this.id,
      this.title,
      this.date,
      this.note,
      this.enteredBy,
      this.type,
      this.prescription,
      this.radiograph,
      this.report,
      this.clerk,
      this.doctor,
      this.medicalFacility});

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    //for get requests
    return MedicalRecord(
      id: json["_id"],
      title: json["value"],
      enteredBy: json['enteredBy'],
      note: json["note"],
      type: json["type"],
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      report: json['report'].fromJson(),
      radiograph: json['radiograph'].fromJson(),
      prescription: json['prescriptionImage'].fromJson(),
      clerk: json['clerk'].fromJson(),
      doctor: json['doctor'].fromJson(),
      medicalFacility: json['medicalFacility'].fromJson(),
    );
  }

  Map<String, dynamic> toJson() {
    //for post requests
    return {
      "title": this.title,
      "note": this.note,
      "enteredBy": this.enteredBy,
      "date": this.date.toIso8601String(),
      "report": this.report.toJson(),
      "radiograph": this.radiograph.toJson(),
      "prescriptionImage": this.prescription.toJson()
    };
  }
}

class MedicalFile {
  String url;
  String fileName;

  MedicalFile({this.url, this.fileName});
  factory MedicalFile.fromJson(Map<String, dynamic> json) {
    return MedicalFile(
      url: json["url"],
      fileName: json["fileName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "url": this.url,
      "fileName": this.fileName,
    };
  }
}

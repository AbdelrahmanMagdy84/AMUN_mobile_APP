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
  String filePath;
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
      this.medicalFacility,
      this.filePath});

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    //for get requests
    return MedicalRecord(
      id: json["_id"],
      title: json["title"],
      enteredBy: json['enteredBy'],
      note: json["notes"],
      type: json["type"],
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      report:
          json['report'] != null ? MedicalFile.fromJson(json['report']) : null,
      radiograph: json['radiograph'] != null
          ? MedicalFile.fromJson(json['radiograph'])
          : null,
      prescription: json['prescriptionImage'] != null
          ? MedicalFile.fromJson(json['prescriptionImage'])
          : null,
      clerk: json['clerk'] != null ? Clerk.fromJson(json['clerk']) : null,
      doctor: json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null,
      medicalFacility: json['medicalFacility'] != null
          ? MedicalFacility.fromJson(json['medicalFacility'])
          : null,
    );
  }

  Map<String, dynamic> toJson(String field) {
    //for post requests
    return {
      "title": this.title,
      "note": this.note,
      "enteredBy": this.enteredBy,
      "date": this.date.toIso8601String(),
      field: this.filePath
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

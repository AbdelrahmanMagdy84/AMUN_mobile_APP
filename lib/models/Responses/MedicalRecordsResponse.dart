import '../MedicalRecord.dart';

class MedicalRecordsResponse {
  String message;
  bool success;
  List<MedicalRecord> medicalRecord;

  MedicalRecordsResponse({
    this.medicalRecord,
    this.message,
    this.success,
  });

  factory MedicalRecordsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> parsedMedicalRecord = json['medicalRecords'] != null
        ? json['medicalRecords']
        : new List<dynamic>();
    List<MedicalRecord> record =
        parsedMedicalRecord.map((i) => MedicalRecord.fromJson(i)).toList();
    return MedicalRecordsResponse(
        success: json["success"],
        message: json["message"],
        medicalRecord: record);
  }
}

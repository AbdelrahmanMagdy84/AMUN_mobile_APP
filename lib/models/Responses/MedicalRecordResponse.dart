import '../MedicalRecord.dart';

class MedicalRecordResponse {
  bool success;
  MedicalRecord medicalRecord;

  MedicalRecordResponse({
    this.medicalRecord,
    this.success,
  });

  factory MedicalRecordResponse.fromJson(Map<String, dynamic> json) {
    return MedicalRecordResponse(
      success: json["success"],
      medicalRecord: json["medicalRecord"] != null
          ? MedicalRecord.fromJson(json["medicalRecord"])
          : null,
    );
  }
}

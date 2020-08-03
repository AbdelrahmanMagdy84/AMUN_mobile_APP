import '../Patient.dart';

class PatientResponse {
  String message;
  bool success;
  Patient patient;

  PatientResponse({
    this.patient,
    this.message,
    this.success,
  });

  factory PatientResponse.fromJson(Map<String, dynamic> json) {
    return PatientResponse(
        success: json["success"],
        message: json["message"],
        patient:
            json["patient"] != null ? Patient.fromJson(json["patient"]) : null);
  }
}

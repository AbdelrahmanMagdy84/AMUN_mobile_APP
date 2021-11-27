import '../Patient.dart';

class PatientResponse {
  String message;
  bool success;
  Patient patient;
  String token;

  PatientResponse({this.patient, this.message, this.success, this.token});

  factory PatientResponse.fromJson(Map<String, dynamic> json) {
    return PatientResponse(
        success: json["success"],
        message: json["message"],
        patient:
            json["patient"] != null ? Patient.fromJson(json["patient"]) : null,
        token: json["patient"]["token"]);
  }
}

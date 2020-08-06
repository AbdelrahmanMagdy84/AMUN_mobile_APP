import '../Doctor.dart';

class DoctorResponse {
  String message;
  bool success;
  Doctor doctor;

  DoctorResponse({this.doctor, this.message, this.success});

  factory DoctorResponse.fromJson(Map<String, dynamic> json) {
    return DoctorResponse(
        success: json["success"],
        message: json["message"],
        doctor:
            json["doctor"] != null ? Doctor.fromJson(json["doctor"]) : null);
  }
}

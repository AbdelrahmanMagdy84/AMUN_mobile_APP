import "../Patient.dart";

class UserResponse {
  String message;
  bool success;
  Patient patient;

  UserResponse({
    this.patient,
    this.message,
    this.success,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        success: json["success"],
        message: json["message"],
        patient:
            json["patient"] != null ? Patient.fromJson(json["patient"]) : null);
  }
}

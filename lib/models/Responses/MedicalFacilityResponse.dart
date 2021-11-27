import '../MedicalFacility.dart';

class MedicalFacilityResponse {
  String message;
  bool success;
  MedicalFacility medicalFacility;

  MedicalFacilityResponse({this.medicalFacility, this.message, this.success});

  factory MedicalFacilityResponse.fromJson(Map<String, dynamic> json) {
    return MedicalFacilityResponse(
        success: json["success"],
        message: json["message"],
        medicalFacility: json["medicalFacility"] != null
            ? MedicalFacility.fromJson(json["medicalFacility"])
            : null);
  }
}

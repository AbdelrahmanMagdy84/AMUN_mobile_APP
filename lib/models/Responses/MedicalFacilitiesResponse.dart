import '../MedicalFacility.dart';

class MedicalFacilitiesResponse {
  bool success;
  List<MedicalFacility> medicalFacilities;

  MedicalFacilitiesResponse({
    this.medicalFacilities,
    this.success,
  });

  factory MedicalFacilitiesResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> parsedmedicalFacility =
        json["facilitiesPatients"]['medicalFacility'] != null
            ? json["facilitiesPatients"]['medicalFacility']
            : new List<dynamic>();
    List<MedicalFacility> medicalFacilities =
        parsedmedicalFacility.map((i) => MedicalFacility.fromJson(i)).toList();
    return MedicalFacilitiesResponse(
        success: json["success"], medicalFacilities: medicalFacilities);
  }
}

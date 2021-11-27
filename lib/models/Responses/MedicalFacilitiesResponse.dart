import '../MedicalFacility.dart';

class MedicalFacilitiesResponse {
  bool success;
  List<MedicalFacility> medicalFacilities;

  MedicalFacilitiesResponse({
    this.medicalFacilities,
    this.success,
  });

  factory MedicalFacilitiesResponse.fromJson(Map<String, dynamic> json) {
    /* List<dynamic> parsedmedicalFacility =
        json["facilitiesPatients"]['medicalFacility'] != null
            ? json["facilitiesPatients"]['medicalFacility']
            : new List<dynamic>();
    List<MedicalFacility> medicalFacilities =
        parsedmedicalFacility.map((i) => MedicalFacility.fromJson(i)).toList(); */
    List<dynamic> parsed = json["facilitiesPatients"] != null
        ? json["facilitiesPatients"]
        : new List<dynamic>();
    List<dynamic> parsedFacilities = [];

    for (final object in parsed) {
      parsedFacilities.add(object["medicalFacility"]);
    }
    List<MedicalFacility> medicalFacilities =
        parsedFacilities.map((i) => MedicalFacility.fromJson(i)).toList();
    return MedicalFacilitiesResponse(
        success: json["success"], medicalFacilities: medicalFacilities);
  }
}

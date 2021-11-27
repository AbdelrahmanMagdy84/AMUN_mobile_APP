import '../Connection.dart';

class FacilityPatientResponse {
  bool success;
  FacilityPatient connection;

  FacilityPatientResponse({this.success, this.connection});

  factory FacilityPatientResponse.fromJson(Map<String, dynamic> json) {
    return FacilityPatientResponse(
        success: json["success"],
        connection: json["facilitiesPatients"] != null
            ? FacilityPatient.fromJson(json["facilitiesPatients"])
            : null);
  }
}

import '../Connection.dart';

class FacilityPatientResponseList {
  bool success;
  List<FacilityPatient> connection;

  FacilityPatientResponseList({this.success, this.connection});

  factory FacilityPatientResponseList.fromJson(Map<String, dynamic> json) {
    List<dynamic> parsedConnection = json['facilitiesPatients'] != null
        ? json['facilitiesPatients']
        : new List<dynamic>();
    List<FacilityPatient> connection = parsedConnection
        .map((i) => FacilityPatient.fromJson(i))
        .toList();
    return FacilityPatientResponseList(
        success: json["success"], connection: connection);
  }
}

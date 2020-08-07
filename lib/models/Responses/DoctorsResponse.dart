import '../Doctor.dart';

class DoctorsResponse {
  bool success;
  List<Doctor> doctors;

  DoctorsResponse({
    this.doctors,
    this.success,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> parsedDoctors = json["facilitiesPatients"]['doctor'] != null
        ? json["facilitiesPatients"]['doctor']
        : new List<dynamic>();
    List<Doctor> doctors =
        parsedDoctors.map((i) => Doctor.fromJson(i)).toList();
    return DoctorsResponse(success: json["success"], doctors: doctors);
  }
}

import '../Doctor.dart';

class DoctorsResponse {
  bool success;
  List<Doctor> doctors;

  DoctorsResponse({
    this.doctors,
    this.success,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> parsed = [];
    if (json["facilitiesPatients"] != null) {
      parsed = json["facilitiesPatients"] != null
          ? json["facilitiesPatients"]
          : new List<dynamic>();
    } else if (json["facilitiesDoctors"] != null) {
      parsed = json["facilitiesDoctors"] != null
          ? json["facilitiesDoctors"]
          : new List<dynamic>();
    }

    List<dynamic> parsedDoctors = [];

    for (final object in parsed) {
      parsedDoctors.add(object["doctor"]);
    }
    List<Doctor> doctors =
        parsedDoctors.map((i) => Doctor.fromJson(i)).toList();

    return DoctorsResponse(success: json["success"], doctors: doctors);
  }
}

import '../BloodPressure.dart';

class BloodPressureResponse {
  String message;
  bool success;
  List<BloodPressure> bloodPressure;

  BloodPressureResponse({
    this.bloodPressure,
    this.message,
    this.success,
  });

  factory BloodPressureResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> parsedMeasure = json['bloodPressure'] != null
        ? json['bloodPressure']
        : new List<dynamic>();
    List<BloodPressure> measure =
        parsedMeasure.map((i) => BloodPressure.fromJson(i)).toList();
    return BloodPressureResponse(
        success: json["success"],
        message: json["message"],
        bloodPressure: measure);
  }
}

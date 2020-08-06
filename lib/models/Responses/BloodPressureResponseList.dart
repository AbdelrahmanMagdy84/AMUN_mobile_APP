import '../BloodPressure.dart';

class BloodPressureResponseList {
  bool success;
  List<BloodPressure> bloodPressure;

  BloodPressureResponseList({
    this.bloodPressure,
    this.success,
  });

  factory BloodPressureResponseList.fromJson(Map<String, dynamic> json) {
    List<dynamic> parsedMeasure = json['bloodPressure'] != null
        ? json['bloodPressure']
        : new List<dynamic>();
    List<BloodPressure> measure =
        parsedMeasure.map((i) => BloodPressure.fromJson(i)).toList();
    return BloodPressureResponseList(
        success: json["success"], bloodPressure: measure);
  }
}

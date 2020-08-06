import '../BloodGlucose.dart';

class BloodGlucoseResponseList {
  String message;
  bool success;
  List<BloodGlucose> bloodGlucose;

  BloodGlucoseResponseList({
    this.bloodGlucose,
    this.message,
    this.success,
  });

  factory BloodGlucoseResponseList.fromJson(Map<String, dynamic> json) {
    List<dynamic> parsedMeasure = json['bloodGlucose'] != null
        ? json['bloodGlucose']
        : new List<dynamic>();
    List<BloodGlucose> measure =
        parsedMeasure.map((i) => BloodGlucose.fromJson(i)).toList();
    return BloodGlucoseResponseList(
        success: json["success"],
        message: json["message"],
        bloodGlucose: measure);
  }
}

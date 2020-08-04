import '../BloodGlucose.dart';

class BloodGlucoseResponse {
  String message;
  bool success;
  List<BloodGlucose> bloodGlucose;

  BloodGlucoseResponse({
    this.bloodGlucose,
    this.message,
    this.success,
  });

  factory BloodGlucoseResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> parsedMeasure = json['bloodGlucose'] != null
        ? json['bloodGlucose']
        : new List<dynamic>();
    List<BloodGlucose> measure =
        parsedMeasure.map((i) => BloodGlucose.fromJson(i)).toList();
    return BloodGlucoseResponse(
        success: json["success"],
        message: json["message"],
        bloodGlucose: measure);
  }
}

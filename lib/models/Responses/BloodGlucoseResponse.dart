import '../BloodGlucose.dart';

class BloodGlucoseResponse {
  bool success;
  BloodGlucose bloodGlucose;

  BloodGlucoseResponse({
    this.bloodGlucose,
    this.success,
  });

  factory BloodGlucoseResponse.fromJson(Map<String, dynamic> json) {
    return BloodGlucoseResponse(
      success: json["success"],
      bloodGlucose: json["bloodGlucose"] != null
          ? BloodGlucose.fromJson(json["bloodGlucose"])
          : null,
    );
  }
}

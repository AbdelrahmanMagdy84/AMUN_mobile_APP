import '../BloodPressure.dart';

class BloodPressureResponse {
  bool success;
  BloodPressure bloodPressure;

  BloodPressureResponse({
    this.bloodPressure,
    this.success,
  });

  factory BloodPressureResponse.fromJson(Map<String, dynamic> json) {
    return BloodPressureResponse(
      success: json["success"],
      bloodPressure: json["bloodPressure"] != null
          ? BloodPressure.fromJson(json["bloodPressure"])
          : null,
    );
  }
}

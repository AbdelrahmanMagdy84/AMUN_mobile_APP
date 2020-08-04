import 'dart:convert';
import 'APIClient.dart';
import 'package:http/http.dart' as http;

import '../models/BloodGlucose.dart';
import '../models/Responses/BloodGlucoseResponse.dart';

class BloodGlucoseService {
  static final String endPoint = "api/v1/blood-glucose";
  static final BloodGlucoseService _instance =
      BloodGlucoseService._getInstance();

  factory BloodGlucoseService() {
    return _instance;
  }
  BloodGlucoseService._getInstance();

  Future<BloodGlucoseResponse> getBloodPressureMeasure(String token) async {
    final http.Response response = await http.get(
        "${APIClient.baseUrl}/$endPoint",
        headers: {"Content-Type": "application/json", "authorization": token});
    if (response.statusCode == 200) {
      return BloodGlucoseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<BloodGlucoseResponse> addBloodPressureMeasure(
      {BloodGlucose bloodGlucose, String token}) async {
    final http.Response response = await http.post(
        "${APIClient.baseUrl}/$endPoint",
        headers: {"Content-Type": "application/json", "authorization": token},
        body: jsonEncode(bloodGlucose.toJson()));
    if (response.statusCode == 200) {
      return BloodGlucoseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}

import 'dart:convert';
import 'APIClient.dart';
import 'package:http/http.dart' as http;

import '../models/BloodGlucose.dart';
import '../models/Responses/BloodGlucoseResponse.dart';
import '../models/Responses/BloodGlucoseResponseList.dart';

class BloodGlucoseService {
  static final String endPoint = "api/v1/blood-glucose";
  static final BloodGlucoseService _instance =
      BloodGlucoseService._getInstance();

  factory BloodGlucoseService() {
    return _instance;
  }
  BloodGlucoseService._getInstance();

  Future<BloodGlucoseResponseList> getBloodGlucoseMeasure(String token) async {
    final http.Response response = await http.get(
        "${APIClient.baseUrl}/$endPoint",
        headers: {"Content-Type": "application/json", "authorization": token});
    if (response.statusCode == 200) {
      return BloodGlucoseResponseList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<BloodGlucoseResponse> addBloodGlucoseMeasure(
      BloodGlucose bloodGlucose, String token) async {
    print(token);
    final http.Response response = await http.post(
        "${APIClient.baseUrl}/$endPoint",
        headers: {"Content-Type": "application/json", "authorization": token},
        body: jsonEncode(bloodGlucose.toJson()));
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return BloodGlucoseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to post data");
    }
  }
}

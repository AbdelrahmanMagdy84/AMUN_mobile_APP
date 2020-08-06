import 'dart:convert';
import 'APIClient.dart';
import 'package:http/http.dart' as http;

import '../models/BloodPressure.dart';
import '../models/Responses/BloodPressureResponse.dart';
import '../models/Responses/BloodPressureResponseList.dart';

class BloodPressureService {
  static final String endPoint = "api/v1/blood-pressure";
  static final BloodPressureService _instance =
      BloodPressureService._getInstance();

  factory BloodPressureService() {
    return _instance;
  }

  BloodPressureService._getInstance();

  Future<BloodPressureResponseList> getBloodPressureMeasure(
      String token) async {
    final http.Response response = await http.get(
        "${APIClient.baseUrl}/$endPoint",
        headers: {"Content-Type": "application/json", "authorization": token});
    if (response.statusCode == 200) {
      return BloodPressureResponseList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<BloodPressureResponse> addBloodPressureMeasure(
      {BloodPressure bloodPressure, String token}) async {
    final http.Response response = await http.post(
        "${APIClient.baseUrl}/$endPoint",
        headers: {"Content-Type": "application/json", "authorization": token},
        body: jsonEncode(bloodPressure.toJson()));
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return BloodPressureResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to post data");
    }
  }
}

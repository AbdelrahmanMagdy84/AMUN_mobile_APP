import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'APIClient.dart';
import '../models/Responses/MedicalFacilityResponse.dart';

class MedicalFacilityService {
  static final String endPoint = "api/v1/medical-facilities";
  static final MedicalFacilityService _instance =
      MedicalFacilityService._getInstance();

  factory MedicalFacilityService() {
    return _instance;
  }
  MedicalFacilityService._getInstance();

  Future<MedicalFacilityResponse> getMedicalFacility(
      String input, String token, String criteria) async {
    print(token);
    final http.Response response = await http.get(
        "${APIClient.baseUrl}/$endPoint/?$criteria=$input",
        headers: {"Content-Type": "application/json", "authorization": token});
    if (response.statusCode == 200) {
      return MedicalFacilityResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}

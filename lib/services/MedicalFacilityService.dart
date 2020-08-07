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

  Future<MedicalFacilityResponse> getMedicalFacilityById(
      String id, String token) async {
    final newURI = Uri.http("${APIClient.baseUrl}", "$endPoint", {"_id": id});
    final http.Response response = await http.get(newURI,
        headers: {"Content-Type": "application/json", "authorization": token});
    if (response.statusCode == 200) {
      return MedicalFacilityResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<MedicalFacilityResponse> getMedicalFacilityByUsername(
      String username, String token) async {
    final newURI =
        Uri.http("${APIClient.baseUrl}", "$endPoint", {"username": username});
    final http.Response response = await http.get(newURI,
        headers: {"Content-Type": "application/json", "authorization": token});
    if (response.statusCode == 200) {
      return MedicalFacilityResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}

import 'dart:convert';
import 'package:amun/models/FacilityPatient.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'APIClient.dart';
import '../models/Responses/MedicalFacilitiesResponse.dart';
import '../models/Responses/DoctorsResponse.dart';

class FacilityPatientService {
  static final String endPoint = "api/v1/facilities-patients";
  static final FacilityPatientService _instance =
      FacilityPatientService._getInstance();

  factory FacilityPatientService() {
    return _instance;
  }
  FacilityPatientService._getInstance();

  Future<void> createConnection(
      FacilityPatient facilityPatient, String token) async {
    final http.Response response = await http.post(
        "${APIClient.baseUrl}/$endPoint",
        body: jsonEncode(facilityPatient.toJson()),
        headers: {"Content-Type": "application/json", "authorization": token});
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to post data");
    }
  }

  Future<MedicalFacilitiesResponse> getMedicalFacilities(String token) async {
    final http.Response response = await http.get(
        "${APIClient.baseUrl}/$endPoint/medicalFacility",
        headers: {"Content-Type": "application/json", "authorization": token});
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return MedicalFacilitiesResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<DoctorsResponse> getDoctors(String token) async {
    final http.Response response = await http.get(
        "${APIClient.baseUrl}/$endPoint/doctor",
        headers: {"Content-Type": "application/json", "authorization": token});
    if (response.statusCode == 200) {
      //print(jsonDecode(response.body));
      return DoctorsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<void> deleteConnection(String id, String token) async {
    final http.Response response = await http.delete(
        "${APIClient.baseUrl}/$endPoint/$id",
        headers: {"Content-Type": "application/json", "authorization": token});
    if (response.statusCode == 200) {
      //print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to delete data");
    }
  }
}

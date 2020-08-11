import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'APIClient.dart';
import '../models/Responses/DoctorsResponse.dart';

class FacilityDoctorService {
  static final String endPoint = "api/v1/facilities-doctors";
  static final FacilityDoctorService _instance =
      FacilityDoctorService._getInstance();

  factory FacilityDoctorService() {
    return _instance;
  }
  FacilityDoctorService._getInstance();

  Future<DoctorsResponse> getDoctors(
      String medicalFacilityId, String token) async {
    final http.Response response = await http.get(
        "${APIClient.baseUrl}/$endPoint/doctor?medicalFacility=$medicalFacilityId",
        headers: {"Content-Type": "application/json", "authorization": token});
    if (response.statusCode == 200) {
      //print(jsonDecode(response.body));
      return DoctorsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}

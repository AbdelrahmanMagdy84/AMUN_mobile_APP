import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'APIClient.dart';
import '../models/Responses/DoctorResponse.dart';

class DoctorService {
  static final String endPoint = "api/v1/doctors";
  static final DoctorService _instance = DoctorService._getInstance();

  factory DoctorService() {
    return _instance;
  }
  DoctorService._getInstance();

  Future<DoctorResponse> getDoctorById(String id, String token) async {
    final newURI = Uri.http("${APIClient.baseUrl}", "$endPoint", {"_id": id});
    final http.Response response = await http.get(newURI,
        headers: {"Content-Type": "application/json", "authorization": token});
    if (response.statusCode == 200) {
      return DoctorResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<DoctorResponse> getDoctorByUsername(
      String username, String token) async {
    print(token);
    final http.Response response = await http.get(
        "${APIClient.baseUrl}/$endPoint/?username=$username",
        headers: {"Content-Type": "application/json", "authorization": token});
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return DoctorResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}

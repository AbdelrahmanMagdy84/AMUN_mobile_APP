import 'dart:convert';
import 'dart:io';
import 'APIClient.dart';
import '../models/Patient.dart';
import 'package:http/http.dart' as http;

class PatientService {
  static final String endPoint = "api/v1/patient";
  static final PatientService _instance = PatientService._getInstance();

  factory PatientService() {
    return _instance;
  }

  PatientService._getInstance();

  Future<Patient> login(
      {String username, String email, String password}) async {
    final http.Response response = await http.post(
        "${APIClient.baseUrl}/v1/auth",
        body: jsonEncode(
            {"username": username, "email": email, "password": password}),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    if (response.statusCode == 200) {
      return Patient.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to login");
    }
  }

  /* Future<UserResponse> signup(User user) async {
    final http.Response response = await http.post(
        "${APIClient.baseUrl}/v1/auth/create",
        body: jsonEncode(user.toJson()),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to signup");
    }
  } */
}

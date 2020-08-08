import 'dart:convert';
import 'dart:io';
import 'APIClient.dart';
import '../models/Patient.dart';
import '../models/Responses/PatientResponse.dart';
import 'package:http/http.dart' as http;

class PatientService {
  static final String endPoint = "api/v1/patients";
  static final PatientService _instance = PatientService._getInstance();

  factory PatientService() {
    return _instance;
  }

  PatientService._getInstance();

  Future<PatientResponse> login(String input, String password) async {
    Map<String, String> body;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input);
    if (emailValid) {
      body = {"email": input, "password": password};
    } else {
      body = {"username": input, "password": password};
    }
    print("${APIClient.baseUrl}/$endPoint/auth");
    final http.Response response = await http.post(
        "${APIClient.baseUrl}/$endPoint/auth",
        body: jsonEncode(body),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    if (response.statusCode == 200) {
      return PatientResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to login");
    }
  }

  Future<PatientResponse> signup(Patient patient) async {
    final http.Response response = await http.post(
        "${APIClient.baseUrl}/$endPoint",
        body: jsonEncode(patient.toJson()),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    if (response.statusCode == 200) {
      return PatientResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to signup");
    }
  }

  Future<PatientResponse> updatePatient(Patient patient, String token) async {
    final http.Response response = await http.patch(
        "${APIClient.baseUrl}/$endPoint",
        body: jsonEncode(patient.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "authorization": token
        });
    if (response.statusCode == 200) {
      return PatientResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update");
    }
  }

  Future<PatientResponse> updatePatientList(
      List<String> list, String type, String token) async {
        print(jsonEncode( {type:jsonEncode(list)}));
    final http.Response response = await http
        .patch("${APIClient.baseUrl}/$endPoint", body: 
     jsonEncode({type:list})
    , headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": token
    });
    if (response.statusCode == 200) {
      return PatientResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update");
    }
  }

  Future<PatientResponse> getPatient(String token) async {
    final http.Response response = await http
        .get("${APIClient.baseUrl}/$endPoint", headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": token
    });
    if (response.statusCode == 200) {
      return PatientResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}

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

  Future<DoctorResponse> getDoctor(
      String input, String token, String criteria) async {
    print(token);
    final http.Response response = await http.get(
        "${APIClient.baseUrl}/$endPoint/?$criteria=$input",
        headers: {"Content-Type": "application/json", "authorization": token});
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return DoctorResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}

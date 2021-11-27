import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'APIClient.dart';
import '../models/Responses/ClerkResponse.dart';

class ClerkService {
  static final String endPoint = "api/v1/clerks";
  static final ClerkService _instance = ClerkService._getInstance();

  factory ClerkService() {
    return _instance;
  }
  ClerkService._getInstance();

  Future<ClerkResponse> getClerkByUsername(
      String username, String token) async {
    final newURI =
        Uri.http("${APIClient.baseUrl}", "$endPoint", {"username": username});
    final http.Response response = await http.get(newURI,
        headers: {"Content-Type": "application/json", "authorization": token});
    if (response.statusCode == 200) {
      return ClerkResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}

import 'dart:convert';
import 'APIClient.dart';
import 'package:http/http.dart' as http;

import '../models/MedicalRecord.dart';
import '../models/Responses/MedicalRecordResponse.dart';
import '../models/Responses/MedicalRecordsResponse.dart';

class MedicalRecordService {
  static final String endPoint = "api/v1/medical-records";
  static final MedicalRecordService _instance =
      MedicalRecordService._getInstance();

  factory MedicalRecordService() {
    return _instance;
  }
  MedicalRecordService._getInstance();

  Future<MedicalRecordsResponse> getMedicalRecords(
      String token, String type) async {
    final http.Response response = await http.get(
        "${APIClient.baseUrl}/$endPoint/?type=$type",
        headers: {"Content-Type": "application/json", "authorization": token});
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return MedicalRecordsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<MedicalRecordResponse> addMedicalRecords(
      MedicalRecord medicalRecord, String token, String type) async {
    /* final http.Response response = await http.post(
        "${APIClient.baseUrl}/$endPoint",
        headers: {"Content-Type": "application/json", "authorization": token},
        body: jsonEncode(medicalRecord.toJson(type)));
    print(jsonDecode(response.body)); */
    print("request begins");
    Map<String, String> headers = {"authorization": token};
    print("headers intializaed");
    var request = http.MultipartRequest(
        'POST', Uri.parse("${APIClient.baseUrl}/$endPoint"));
    print("assigning header");
    request.headers.addAll(headers);
    print("assigning fields");
    request.fields['date'] = medicalRecord.date.toIso8601String();
    request.fields['notes'] = medicalRecord.note;
    request.fields['enteredBy'] = medicalRecord.enteredBy;
    request.fields['title'] = medicalRecord.title;
    request.fields['type'] = medicalRecord.type;
    print("assigning files");
    request.files
        .add(await http.MultipartFile.fromPath(type, medicalRecord.filePath));
    print("sending requests");
    print(request.fields);
    var streamedResponse = await request.send();
    print("response received");
    var response = await http.Response.fromStream(streamedResponse);
    print("response converted");
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      print("success");
      return MedicalRecordResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to post data");
    }
  }
}

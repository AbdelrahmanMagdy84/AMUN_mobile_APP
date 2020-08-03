import 'PatientService.dart';

class APIClient {
  static final String baseUrl = "https://amonmr.herokuapp.com/";
  static final APIClient _instance = APIClient._getInstance();
  static final PatientService _patientService = PatientService();
  factory APIClient() {
    return _instance;
  }

  APIClient._getInstance();

  PatientService getPatientService() {
    return _patientService;
  }
}

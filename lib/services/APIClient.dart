import 'BloodGlucoseService.dart';
import 'BloodPressureService.dart';

import 'PatientService.dart';

class APIClient {
  static final String baseUrl = "https://amonmr.herokuapp.com";
  static final APIClient _instance = APIClient._getInstance();
  static final PatientService _patientService = PatientService();
  static final BloodPressureService _bloodPressureService =
      BloodPressureService();
  static final BloodGlucoseService _bloodGlucoseService = BloodGlucoseService();

  factory APIClient() {
    return _instance;
  }

  APIClient._getInstance();

  PatientService getPatientService() {
    return _patientService;
  }

  BloodGlucoseService getBloodGlucoseService() {
    return _bloodGlucoseService;
  }

  BloodPressureService getBloodPressureService() {
    return _bloodPressureService;
  }
}

import 'BloodGlucoseService.dart';
import 'BloodPressureService.dart';
import 'DoctorService.dart';
import 'PatientService.dart';
import 'ClerkService.dart';
import 'MedicalFacilityService.dart';
import 'FacilityPatientService.dart';
import 'MedicalRecordService.dart';

class APIClient {
  static final String baseUrl = "https://amonmr.herokuapp.com";
  static final APIClient _instance = APIClient._getInstance();
  static final PatientService _patientService = PatientService();
  static final BloodPressureService _bloodPressureService =
      BloodPressureService();
  static final BloodGlucoseService _bloodGlucoseService = BloodGlucoseService();
  static final DoctorService _doctorService = DoctorService();
  static final ClerkService _clerkService = ClerkService();
  static final MedicalFacilityService _medicalFacilityService =
      MedicalFacilityService();
  static final FacilityPatientService _facilityPatientService =
      FacilityPatientService();
  static final MedicalRecordService _medicalRecordService =
      MedicalRecordService();
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

  DoctorService getDoctorService() {
    return _doctorService;
  }

  ClerkService getClerkService() {
    return _clerkService;
  }

  MedicalFacilityService getMedicalFacilityService() {
    return _medicalFacilityService;
  }

  FacilityPatientService getFacilityPatientService() {
    return _facilityPatientService;
  }

  MedicalRecordService getMedicalRecordService() {
    return _medicalRecordService;
  }
}

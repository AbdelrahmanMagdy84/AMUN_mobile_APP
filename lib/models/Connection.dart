import 'package:amun/models/Doctor.dart';
import 'package:amun/models/MedicalFacility.dart';

class FacilityPatient {
  Doctor doctor;
  MedicalFacility medicalFacility;
  String id;

  FacilityPatient({this.id, this.doctor, this.medicalFacility});

  factory FacilityPatient.fromJson(Map<String, dynamic> json) {
    return FacilityPatient(
        id: json["_id"],
        doctor: json["doctor"] != null ? Doctor.fromJson(json["doctor"]) : null,
        medicalFacility: json["medicalFacility"] != null
            ? MedicalFacility.fromJson(json["medicalFacility"])
            : null);
  }
}

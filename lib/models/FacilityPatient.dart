class FacilityPatient {
  String doctor;
  String medicalFacility;

  FacilityPatient({this.doctor, this.medicalFacility});

  Map<String, dynamic> toJson() {
    return {"doctor": this.doctor, "medicalFacility": this.medicalFacility};
  }
}

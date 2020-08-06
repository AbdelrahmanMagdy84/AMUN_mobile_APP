class MedicalRecord {
  int id;
  DateTime date;
  String title;
  String doctor;
  String image;
  String note;

  MedicalRecord(
      {this.id, this.title, this.doctor, this.date, this.image, this.note});
}

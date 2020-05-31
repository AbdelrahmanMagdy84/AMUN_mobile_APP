class Appointment {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final String title;
  final String descrption;
  Appointment(
      {this.id, this.title, this.startTime, this.endTime, this.descrption});
}

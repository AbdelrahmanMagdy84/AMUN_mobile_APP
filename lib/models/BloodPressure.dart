class BloodPressure {
  String id;
  int upper;
  int lower;
  String note;
  DateTime date;

  BloodPressure({this.id, this.upper, this.lower, this.note, this.date});

  factory BloodPressure.fromJson(Map<String, dynamic> json) {
    return BloodPressure(
      id: json["_id"],
      upper: json["value"]["diastolic"],
      lower: json["value"]["systolic"],
      note: json["note"],
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "value": {
        "diastolic": this.upper,
        "systolic": this.lower,
      },
      "note": this.note,
      "date": this.date.toIso8601String()
    };
  }
}

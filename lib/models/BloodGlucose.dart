enum TimeType { fasting, afterEating, two_three_hours_aftrer_eating }

class BloodGlucose {
  String id;
  int value;
  TimeType timeType;
  String note;
  DateTime date;

  BloodGlucose({this.id, this.value, this.date, this.timeType, this.note});

  factory BloodGlucose.fromJson(Map<String, dynamic> json) {
    return BloodGlucose(
      id: json["_id"],
      value: json["value"],
      timeType: json["type"],
      note: json["note"],
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": this.id,
      "value": this.value,
      "type": this.timeType,
      "note": this.note,
      "date": this.date
    };
  }
}

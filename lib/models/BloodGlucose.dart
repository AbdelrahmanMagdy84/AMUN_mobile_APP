enum TimeType { fasting, afterEating, two_three_hours_aftrer_eating }

class BloodGlucose {
  String id;
  int value;
  TimeType timeType;
  String note;
  DateTime date;

  BloodGlucose({this.id, this.value, this.date, this.timeType, this.note});

  factory BloodGlucose.fromJson(Map<String, dynamic> json) {
    TimeType timeType = TimeType.values
        .firstWhere((e) => e.toString() == 'TimeType.' + json["type"]);
    return BloodGlucose(
      id: json["_id"],
      value: json["value"],
      timeType: timeType, //string to enum
      note: json["note"],
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "value": this.value,
      "type": this.timeType.toString().split('.').last, //enum to string
      "note": this.note,
      "date": this.date.toIso8601String(),
    };
  }
}

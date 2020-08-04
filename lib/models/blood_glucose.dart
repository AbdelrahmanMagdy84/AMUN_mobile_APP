enum TimeType{fasting,afterEating,two_three_hours_aftrer_eating}


class BloodGlucose{
  int id; 
  int value;
  TimeType timeType;
  DateTime date;
  BloodGlucose({this.id,this.value,this.date,this.timeType});
}
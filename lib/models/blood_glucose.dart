enum Type{fasting,postprandial,random}


class BloodGlucose{
  int id; 
  int value;
  Type type;
  DateTime date;
  BloodGlucose({this.id,this.value,this.date,this.type});
}
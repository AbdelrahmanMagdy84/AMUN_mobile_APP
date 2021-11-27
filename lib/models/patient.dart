class Patient {
  String pid;
  String username;
  String password;
  String email;
  String mobile;
  String firstName;
  String lastName;
  DateTime birthDate;
  String gender;
  String bloodType;
  List<String> medications;
  List<String> allergies;
  List<String> conditions;
  DateTime createdAt;
  DateTime updatedAt;

  Patient(
      {this.pid,
      this.firstName,
      this.lastName,
      this.password,
      this.mobile,
      this.gender,
      this.email,
      this.username,
      this.birthDate,
      this.bloodType,
      this.medications,
      this.allergies,
      this.conditions,
      this.createdAt,
      this.updatedAt});

  factory Patient.fromJson(Map<String, dynamic> json) {
    List<dynamic> parsedMedications =
        json['medications'] != null ? json['medications'] : new List<dynamic>();
    List<String> medications =
        parsedMedications.map((i) => i.toString()).toList();

    List<dynamic> parsedAllergies =
        json['allergies'] != null ? json['allergies'] : new List<dynamic>();
    List<String> allergies = parsedAllergies.map((i) => i.toString()).toList();

    List<dynamic> parsedConditions =
        json['conditions'] != null ? json['conditions'] : new List<dynamic>();
    List<String> conditions =
        parsedConditions.map((i) => i.toString()).toList();

    return Patient(
      pid: json["_id"],
      password: json["password"],
      username: json["username"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      mobile: json["mobile"],
      gender: json["gender"],
      bloodType: json["bloodType"],
      birthDate: DateTime.parse(json["birthDate"]),
      medications: medications,
      allergies: allergies,
      conditions: conditions,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "password": this.password,
      "email": this.email,
      "username": this.username,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "mobile": this.mobile,
      "gender": this.gender,
      "birthDate": this.birthDate.toIso8601String(),
      "medications": this.medications,
      "bloodType": this.bloodType,
      "allergies": this.allergies,
      "conditions": this.conditions,
    };
  }
}

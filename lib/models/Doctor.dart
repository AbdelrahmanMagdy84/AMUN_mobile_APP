class Doctor {
  String id;
  String firstName;
  String lastName;
  String email;
  String username;
  String bio;
  String address;
  String mobile;
  DateTime birthDate;
  String gender;
  String specialization;

  Doctor(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.username,
      this.address,
      this.bio,
      this.mobile,
      this.birthDate,
      this.gender,
      this.specialization});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        username: json["username"],
        address: json["address"],
        mobile: json["mobile"],
        bio: json["bio"],
        birthDate: DateTime.parse(json["birthDate"]),
        gender: json["gender"],
        specialization: json["specialization"]);
  }
}

class Clerk {
  int id;
  String firstName;
  String lastName;
  String email;
  String username;
  String role;
  String mobile;
  String gender;

  Clerk({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.role,
    this.mobile,
    this.gender,
  });

  factory Clerk.fromJson(Map<String, dynamic> json) {
    return Clerk(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      username: json["username"],
      mobile: json["mobile"],
      gender: json["gender"],
    );
  }
}

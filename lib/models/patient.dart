enum Gender {
  Male,
  Female,
}

class Patient {
  int pid;
  String username;
  String password;
  String email;
  int phone;
  String name;
  DateTime dateOfBirth;
  Gender gender;
  String bloodType;
  List<String> medecations;
  List<String> allergies;
  List<String> condtions;
  Patient(
      {this.pid,
      this.name,
      this.password,
      this.phone,
      this.gender,
      this.email,
      this.username,
      this.dateOfBirth,
      this.bloodType,
      this.medecations,
      this.allergies,
      this.condtions});
}

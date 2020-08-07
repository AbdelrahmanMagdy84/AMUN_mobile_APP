class MedicalFacility {
  String id;
  String name;
  String email;
  String username;
  String description;
  String address;
  String mobile;
  String type;

  MedicalFacility(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.address,
      this.description,
      this.mobile,
      this.type});

  factory MedicalFacility.fromJson(Map<String, dynamic> json) {
    return MedicalFacility(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        address: json["address"],
        mobile: json["mobile"],
        description: json["description"],
        type: json["type"]);
  }
}

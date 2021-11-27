import '../Clerk.dart';

class ClerkResponse {
  String message;
  bool success;
  Clerk clerk;

  ClerkResponse({this.clerk, this.message, this.success});

  factory ClerkResponse.fromJson(Map<String, dynamic> json) {
    return ClerkResponse(
        success: json["success"],
        message: json["message"],
        clerk: json["clerk"] != null ? Clerk.fromJson(json["clerk"]) : null);
  }
}

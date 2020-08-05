import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final String _userToken = "token";
  final storage = new FlutterSecureStorage();
  static final TokenStorage _instance = TokenStorage._privateConstructor();

  factory TokenStorage() {
    return _instance;
  }
  TokenStorage._privateConstructor();

  Future<void> saveUserToken(String token) async {
    await storage.write(key: _userToken, value: token);
  }

  Future<String> getUserToken() async {
    String value = await storage.read(key: _userToken);
    return value;
  }

  Future<void> removeUserToken() async {
    await storage.delete(key: "token");
  }

  Future<bool> isAuth() async {
    String value = await storage.read(key: "token");
    if (value != null) {
      return true;
    }
    return false;
  }
}

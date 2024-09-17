import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

// save the access token
Future<void> saveToken(String token, String refresh) async {
  await storage.write(key: 'access', value: token);
  await storage.write(key: 'refresh', value: refresh);
}

// save the user
Future<void> saveUser(String user) async {
  await storage.write(key: 'user', value: user);
}

// get the access token
Future<String?> getToken() async {
  return await storage.read(key: 'access');
}

// get the access token
Future<String?> getRefreshToken() async {
  return await storage.read(key: 'refresh');
}

// delete saved info
Future<void> deleteRefToken() async {
  await storage.deleteAll();
}

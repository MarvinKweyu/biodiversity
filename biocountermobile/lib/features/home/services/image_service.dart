import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageService {
  Future<Map<String, dynamic>> submitImages(
      List<Map<String, dynamic>> images) async {
    // Simulate a network request
    final resp = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/account-auth/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'images': images,
      }),
    );
    if (resp.statusCode == 200) {
      final decodedRes = jsonDecode(resp.body);

      return decodedRes;
    } else {
      throw Exception('Failed to submit your images');
    }
  }
}

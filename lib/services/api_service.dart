import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = "https://works.plinemotors.kr/api-login";

  static Future<String?> fetchNameFromApi(String email) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'email': email},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['name']; // 이름 반환
      } else {
        return null;
      }
    } catch (e) {
      print("API Error: $e");
      return null;
    }
  }
}

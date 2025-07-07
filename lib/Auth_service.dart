import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/login_api.dart';

class AuthService {
  Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse(
      'https://entrance-test-api.datahex.co/api/v1/auth/login/',
    );
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = loginResponseFromJson(response.body);
        return data;

        // if (data != null && data['user'] != null) {
        //   final userName = data['user']['userDisplayName'];
        //   return userName;
        // }
        // else {
        //   throw Exception("User data not found in the response");
        // }
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Login failed');
      }
    } catch (e) {
      print("Error occurred: $e");
      throw Exception("An error occurred while logging in");
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/login_api.dart';

class AuthProvider with ChangeNotifier {
  String? _userName;
  bool _isLoggedIn = false;
  bool _obscurepswd = true;
  LoginResponse? _response;
  bool _isLoading = false;

  String? get userName => _userName;
  bool get isLoggedIn => _isLoggedIn;
  bool get obscurepswd => _obscurepswd;
  LoginResponse? get response => _response;
  bool  get isLoading => _isLoading;


  obscurePassword()
  {
    _obscurepswd = !_obscurepswd;
    notifyListeners();
  }

  loading(bool value){
    _isLoading=value;
    notifyListeners();
  }



  void logout() {
    _userName = null;
    _isLoggedIn = false;
    notifyListeners(); // 🔔 Update UI
  }

  Future<void> login(String email, String password) async {
    loading(true);
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
        _response = loginResponseFromJson(response.body);
        notifyListeners();
        // return data;

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
      loading(false);
    } catch (e) {
      print("Error occurred: $e");
      throw Exception("An error occurred while logging in");
    }
  }
}

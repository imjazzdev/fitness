import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "https://asia-southeast2-hppinjam.cloudfunctions.net";

  // Fungsi untuk menghapus workout
  Future<bool> deleteWorkout(String workoutId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/deletehp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': workoutId}),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fungsi untuk registrasi
  Future<Map<String, dynamic>> register(String username, String email, String password) async {
    final url = Uri.parse("$baseUrl/registeruser");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    return _handleResponse(response);
  }

  // Fungsi untuk login
  Future<Map<String, dynamic>> login(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse('https://asia-southeast2-hppinjam.cloudfunctions.net/Login'),
      body: json.encode({
        'username': username,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Login failed'};
    }
  } catch (e) {
    return {'success': false, 'message': 'Error: $e'};
  }
}

  // Fungsi menyimpan token PASETO ke SharedPreferences
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  // Fungsi menangani respons
  Map<String, dynamic> _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {"success": true, "data": data};
    } else {
      return {"success": false, "message": data['message'] ?? 'Unknown error'};
    }
  }
}

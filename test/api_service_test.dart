import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:fitness/view/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Membuat mock untuk http.Client
class MockClient extends Mock implements http.Client {}

void main() {
  group('ApiService Tests', () {
    late ApiService apiService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      apiService = ApiService();
    });

    test('Login returns success when response status is 200', () async {
      // Mock response
      when(mockClient.post(
        Uri.parse('https://asia-southeast2-hppinjam.cloudfunctions.net/Login'),
        body: json.encode({'username': 'testuser', 'password': 'testpass'}),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer(
        (_) async => http.Response(
            '{"success": true, "message": "Login successful"}', 200),
      );

      // Mengganti client di ApiService
      // apiService.client = mockClient;

      // Melakukan test login
      final result = await apiService.login('testuser', 'testpass');

      // Memastikan hasil yang diterima sesuai dengan response yang dimock
      expect(result['success'], true);
      expect(result['message'], 'Login successful');
    });

    test('Login returns failure when response status is not 200', () async {
      // Mock response
      when(mockClient.post(
        Uri.parse('https://asia-southeast2-hppinjam.cloudfunctions.net/Login'),
        body: json.encode({'username': 'testuser', 'password': 'testpass'}),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer(
        (_) async =>
            http.Response('{"success": false, "message": "Login failed"}', 400),
      );

      // Mengganti client di ApiService
      // apiService.client = mockClient;

      // Melakukan test login
      final result = await apiService.login('testuser', 'testpass');

      // Memastikan hasil yang diterima sesuai dengan response yang dimock
      expect(result['success'], false);
      expect(result['message'], 'Login failed');
    });

    test('Register returns success when response status is 200', () async {
      // Mock response
      when(mockClient.post(
        Uri.parse(
            'https://asia-southeast2-hppinjam.cloudfunctions.net/registeruser'),
        body: json.encode({
          'username': 'newuser',
          'email': 'newuser@example.com',
          'password': 'newpassword',
        }),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer(
        (_) async => http.Response('{"success": true, "data": {}}', 200),
      );

      // Mengganti client di ApiService
      // apiService.client = mockClient;

      // Melakukan test register
      final result = await apiService.register(
          'newuser', 'newuser@example.com', 'newpassword');

      // Memastikan hasil yang diterima sesuai dengan response yang dimock
      expect(result['success'], true);
    });

    test('Delete workout returns true when status is 200', () async {
      // Mock response
      when(mockClient.post(
        Uri.parse(
            'https://asia-southeast2-hppinjam.cloudfunctions.net/deletehp'),
        body: json.encode({'id': '123'}),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer(
        (_) async => http.Response('{"status": true}', 200),
      );

      // Mengganti client di ApiService
      // apiService.client = mockClient;

      // Melakukan test delete
      final result = await apiService.deleteWorkout('123');

      // Memastikan hasilnya benar
      expect(result, true);
    });

    test('Save token stores token in SharedPreferences', () async {
      // Mock SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = 'test_token';

      // Menyimpan token
      await apiService.saveToken(token);

      // Mengambil token yang disimpan
      final savedToken = prefs.getString('token');

      // Memastikan token disimpan dengan benar
      expect(savedToken, token);
    });
  });
}

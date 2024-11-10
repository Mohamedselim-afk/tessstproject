import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post(
        'https://your-api-url.com/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  Future<void> sendLocation(double latitude, double longitude) async {
    try {
      await _dio.post(
        'https://your-api-url.com/location',
        data: {
          'latitude': latitude,
          'longitude': longitude,
        },
      );
    } catch (e) {
      throw Exception('Error sending location: ${e.toString()}');
    }
  }
}


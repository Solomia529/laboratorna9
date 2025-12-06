import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://solomia529.requestcatcher.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  Future<void> sendAuthData({
    required String path, // /login, /signup, /reset
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      // RequestCatcher просто покаже тобі ці дані у браузері
      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');
    } catch (e) {
      print('ERROR WHILE SENDING: $e');
      rethrow;
    }
  }
}

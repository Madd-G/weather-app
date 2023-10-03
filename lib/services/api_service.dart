import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;
  static const String baseUrl = 'https://ibnux.github.io/BMKG-importer/';
  static final ApiService _apiService = ApiService._internal(
    Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(
          seconds: 10,
        ),
        receiveTimeout: const Duration(
          seconds: 10,
        ),
      ),
    ),
  );

  factory ApiService() => _apiService;

  ApiService._internal(this.dio);
}

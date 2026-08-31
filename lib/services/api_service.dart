import 'package:dio/dio.dart';
import 'package:practice/models/post_model.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: Duration(seconds: 10),
    ),
  );

  ApiService() {
    _dio.interceptors.add(
      LogInterceptor(
        responseHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await _dio.get('/posts');

      // Access 'posts' array from DummyJSON response object
      final List<dynamic> rawData = response.data['posts'];

      return rawData.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

}

import 'dart:convert';

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

      // 1. Access the nested 'posts' list from the returned JSON map
      List<dynamic> rawData = response.data['posts'];

      // 2. Map the list items to your Post model
      return rawData.map((json) => Post.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load posts: ${e.message}');
    }
  }

}

import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

enum LoadingState { initial, loading, loaded, error }

class PostProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Post> _posts = [];
  LoadingState _state = LoadingState.initial;
  String _errorMessage = '';

  List<Post> get posts => _posts;
  LoadingState get state => _state;
  String get errorMessage => _errorMessage;

  Future<void> fetchPosts() async {
    _state = LoadingState.loading;
    notifyListeners(); // 1. Triggers CircularProgressIndicator

    try {
      _posts = await _apiService.fetchPosts();
      _state = LoadingState.loaded; // 2. Sets state to loaded
    } catch (e, stackTrace) {
      // Print exact error to Android Studio terminal
      print('PROVIDER ERROR: $e');
      print('STACK TRACE: $stackTrace');

      _errorMessage = e.toString();
      _state = LoadingState.error;
    }

    notifyListeners(); // 3. Triggers UI re-render with loaded data or error
  }
}
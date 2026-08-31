import 'package:flutter/material.dart';
import 'package:practice/screens/post_screen.dart';
import 'package:provider/provider.dart';
import 'providers/post_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PostsScreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data immediately when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts (Provider)')),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.state == LoadingState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.state == LoadingState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.errorMessage,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => provider.fetchPosts(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.posts.isEmpty) {
            return const Center(child: Text('No posts found.'));
          }

          return RefreshIndicator(
            onRefresh: provider.fetchPosts,
            child: ListView.builder(
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                final post = provider.posts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${post.id}')),
                    title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
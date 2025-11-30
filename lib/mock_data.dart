import 'package:flutter_web_app/models.dart';

class MockData {
  static final List<Community> communities = [
    const Community(
      id: '1',
      name: 'FlutterDev',
      description: 'A community for Flutter developers.',
    ),
    const Community(
      id: '2',
      name: 'DartLang',
      description: 'Everything about the Dart programming language.',
    ),
    const Community(
      id: '3',
      name: 'WebDev',
      description: 'General web development discussions.',
    ),
  ];

  static final List<Post> posts = [
    Post(
      id: '1',
      title: 'Flutter 3.0 Released!',
      content:
          'Flutter 3.0 is here with support for macOS and Linux, along with many performance improvements.',
      author: 'flutter_fan',
      communityId: '1',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      upvotes: 150,
      downvotes: 2,
    ),
    Post(
      id: '2',
      title: 'Why I love Dart',
      content:
          'Dart is such a productive language. The type system is great and the tooling is top notch.',
      author: 'dart_lover',
      communityId: '2',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      upvotes: 85,
      downvotes: 5,
    ),
    Post(
      id: '3',
      title: 'CSS Grid vs Flexbox',
      content:
          'When should you use Grid and when should you use Flexbox? Let\'s discuss.',
      author: 'web_wizard',
      communityId: '3',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      upvotes: 42,
      downvotes: 0,
    ),
    Post(
      id: '4',
      title: 'State Management in Flutter',
      content:
          'There are so many options: Provider, Riverpod, Bloc, GetX. Which one do you prefer?',
      author: 'state_master',
      communityId: '1',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      upvotes: 200,
      downvotes: 15,
    ),
  ];

  static List<Post> getPosts() {
    return posts;
  }

  static void addPost(Post post) {
    posts.insert(0, post); // Add to the top of the list
  }

  static void addCommunity(Community community) {
    communities.add(community);
  }

  static Community getCommunity(String id) {
    return communities.firstWhere((c) => c.id == id,
        orElse: () => const Community(
            id: '0', name: 'Unknown', description: 'Unknown community'));
  }

  static void updatePost(Post updatedPost) {
    final index = posts.indexWhere((p) => p.id == updatedPost.id);
    if (index != -1) {
      posts[index] = updatedPost;
    }
  }
}

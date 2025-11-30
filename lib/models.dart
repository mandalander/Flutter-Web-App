class Community {
  final String id;
  final String name;
  final String description;

  const Community({
    required this.id,
    required this.name,
    required this.description,
  });
}

class Post {
  final String id;
  final String title;
  final String content;
  final String author;
  final String communityId;
  final DateTime timestamp;
  final int upvotes;
  final int downvotes;

  const Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.communityId,
    required this.timestamp,
    this.upvotes = 0,
    this.downvotes = 0,
  });

  Post copyWith({
    String? id,
    String? title,
    String? content,
    String? author,
    String? communityId,
    DateTime? timestamp,
    int? upvotes,
    int? downvotes,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      communityId: communityId ?? this.communityId,
      timestamp: timestamp ?? this.timestamp,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
    );
  }
}

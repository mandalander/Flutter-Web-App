import 'package:flutter/material.dart';
import 'package:flutter_web_app/models.dart';
import 'package:flutter_web_app/mock_data.dart';
import 'package:flutter_web_app/glass_container.dart';
import 'package:flutter_web_app/post_details_page.dart';
import 'package:flutter_web_app/community_page.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late Post _post;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
  }

  void _handleUpvote() {
    setState(() {
      _post = _post.copyWith(upvotes: _post.upvotes + 1);
    });
    MockData.updatePost(_post);
  }

  void _handleDownvote() {
    setState(() {
      _post = _post.copyWith(downvotes: _post.downvotes + 1);
    });
    MockData.updatePost(_post);
  }

  @override
  Widget build(BuildContext context) {
    final community = MockData.getCommunity(_post.communityId);

    return GlassContainer(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommunityPage(community: community),
                    ),
                  );
                },
                child: Text(
                  'r/${community.name}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                '• Posted by u/${_post.author}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: 8.0),
              Text(
                '• ${_post.timestamp.toString().substring(0, 16)}', // Simple formatting
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            _post.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8.0),
          Text(_post.content),
          const SizedBox(height: 12.0),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_upward, size: 20),
                onPressed: _handleUpvote,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 4),
              Text('${_post.upvotes}'),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.arrow_downward, size: 20),
                onPressed: _handleDownvote,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailsPage(post: _post),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Icon(Icons.comment, size: 20),
                    SizedBox(width: 4),
                    Text('Comments'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

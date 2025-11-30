import 'package:flutter/material.dart';
import 'package:flutter_web_app/models.dart';
import 'package:flutter_web_app/mock_data.dart';
import 'package:flutter_web_app/glass_container.dart';
import 'package:flutter_web_app/gradient_background.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;

  const PostDetailsPage({super.key, required this.post});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  late Post _post;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _post = widget.post;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
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

  void _submitComment() {
    if (_commentController.text.isNotEmpty) {
      final newComment = Comment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        postId: _post.id,
        author: 'current_user', // Mock user
        content: _commentController.text,
        timestamp: DateTime.now(),
      );

      setState(() {
        MockData.addComment(newComment);
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final comments = MockData.getCommentsForPost(_post.id);
    final community = MockData.getCommunity(_post.communityId);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(_post.title),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            GlassContainer(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'r/${community.name}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '• Posted by u/${_post.author}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '• ${_post.timestamp.toString().substring(0, 16)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    _post.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    _post.content,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_upward),
                        onPressed: _handleUpvote,
                      ),
                      Text('${_post.upvotes}'),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward),
                        onPressed: _handleDownvote,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'Comments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            GlassContainer(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _submitComment,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            if (comments.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                      'No comments yet. Be the first to share your thoughts!'),
                ),
              )
            else
              ...comments.map((comment) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'u/${comment.author}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                comment.timestamp.toString().substring(0, 16),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(comment.content),
                        ],
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}

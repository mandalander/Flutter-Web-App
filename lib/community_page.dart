import 'package:flutter/material.dart';
import 'package:flutter_web_app/models.dart';
import 'package:flutter_web_app/mock_data.dart';
import 'package:flutter_web_app/glass_container.dart';
import 'package:flutter_web_app/gradient_background.dart';
import 'package:flutter_web_app/post_card.dart';

class CommunityPage extends StatelessWidget {
  final Community community;

  const CommunityPage({super.key, required this.community});

  @override
  Widget build(BuildContext context) {
    final posts = MockData.getPostsByCommunity(community.id);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('r/${community.name}'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GlassContainer(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'r/${community.name}',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      community.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Posts',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8.0),
            if (posts.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('No posts in this community yet.'),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostCard(post: posts[index]);
                },
              ),
          ],
        ),
      ),
    );
  }
}

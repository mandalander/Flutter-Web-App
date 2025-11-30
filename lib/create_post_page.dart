import 'package:flutter/material.dart';
import 'package:flutter_web_app/mock_data.dart';
import 'package:flutter_web_app/models.dart';
import 'package:flutter_web_app/glass_container.dart';
import 'package:flutter_web_app/gradient_background.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  String? _selectedCommunityId;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GlassContainer(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value!;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Community',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: _selectedCommunityId,
                    items: MockData.communities.map((community) {
                      return DropdownMenuItem(
                        value: community.id,
                        child: Text(community.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCommunityId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a community';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter content';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _content = value!;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submitPost,
                      child: const Text('Post'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitPost() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newPost = Post(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _title,
        content: _content,
        author: 'current_user', // Placeholder
        communityId: _selectedCommunityId!,
        timestamp: DateTime.now(),
      );

      MockData.addPost(newPost);

      Navigator.pop(context, true); // Return true to indicate post created
    }
  }
}

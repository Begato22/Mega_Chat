import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: const Center(
        child: Text('NewPost'),
      ),
    );
  }
}

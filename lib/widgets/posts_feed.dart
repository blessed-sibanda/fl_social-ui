import 'package:flutter/material.dart';

class PostsFeed extends StatefulWidget {
  const PostsFeed({Key? key}) : super(key: key);

  @override
  _PostsFeedState createState() => _PostsFeedState();
}

class _PostsFeedState extends State<PostsFeed> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.feed,
          size: 120.0,
          color: Colors.lightGreen,
        ),
      ),
    );
  }
}

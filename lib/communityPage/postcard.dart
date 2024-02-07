import 'package:flutter/material.dart';

class PostContainer extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String caption;
  final String imagePath;
  final String profileImagePath;

  const PostContainer({
    Key? key,
    required this.username,
    required this.timeAgo,
    required this.caption,
    required this.imagePath,
    required this.profileImagePath,
  }) : super(key: key);

  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  int _likes = 0;
  final List<String> _comments = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),  
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.profileImagePath),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Posted ${widget.timeAgo}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Add functionality for more options if needed
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.caption,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Image.network(
            widget.imagePath,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      setState(() {
                        _likes++;
                      });
                    },
                  ),
                  Text("$_likes likes"),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // Add functionality for sharing
                },
              ),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {
                  _showCommentDialog();
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (_comments.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _comments
                  .map(
                    (comment) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        comment,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  void _showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newComment = "";
        return AlertDialog(
          title: const Text("Add a Comment"),
          content: TextField(
            onChanged: (value) {
              newComment = value;
            },
            decoration: const InputDecoration(hintText: "Type your comment"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _comments.add(newComment);
                });
                Navigator.of(context).pop();
              },
              child: const Text("Comment"),
            ),
          ],
        );
      },
    );
  }
}

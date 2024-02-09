// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late SharedPreferences _preferences;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _likes = _preferences.getInt("${widget.username}_likes") ?? 0;
      _comments.addAll(_preferences.getStringList(
            "${widget.username}_comments",
          ) ??
          []);
      _isLiked = _preferences.getBool("${widget.username}_isLiked") ?? false;
    });
  }

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
            color: Colors.grey.withOpacity(0.3),
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
                      "Posted ${getTime(widget.timeAgo)}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            widget.caption,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          if (widget.imagePath.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(
                bottom: 10.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  widget.imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: _isLiked
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_border),
                    onPressed: () {
                      _handleLike();
                    },
                  ),
                  Text("$_likes likes"),
                ],
              ),
              const Gap(20.0),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.comment,
                    ),
                    onPressed: () {
                      _showCommentDialog();
                    },
                  ),
                  const Text("Comment"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Comment Section:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Divider(),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return _buildCommentTile(_comments[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentTile(String comment, int index) {
    // bool isCommentLiked =
    //     _preferences.getBool("${widget.username}_comment_${index}_isLiked") ??
    //         false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.profileImagePath),
        ),
        title: Text(
          widget.username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          comment,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // IconButton(
            //   icon: isCommentLiked
            //       ? const Icon(
            //           Icons.favorite,
            //           color: Colors.red,
            //         )
            //       : const Icon(Icons.favorite_border),
            //   onPressed: () {
            //     _handleCommentLike(index);
            //   },
            // ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteComment(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likes++;
      } else {
        _likes--;
      }
    });
    _saveData();
  }

  // void _handleCommentLike(int index) {
  //   bool isCommentLiked =
  //       _preferences.getBool("${widget.username}_comment_${index}_isLiked") ??
  //           false;

  //   setState(() {
  //     isCommentLiked = !isCommentLiked;
  //   });

  //   _preferences.setBool(
  //       "${widget.username}_comment_${index}_isLiked", isCommentLiked);
  // }

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
                _addComment(newComment);
                Navigator.of(context).pop();
              },
              child: const Text("Comment"),
            ),
          ],
        );
      },
    );
  }

  void _addComment(String newComment) {
    setState(() {
      _comments.add(newComment);
    });
    _saveData(); // Save comments to SharedPreferences
  }

  void _deleteComment(int index) {
    setState(() {
      _comments.removeAt(index);
    });
    _saveData(); // Save comments to SharedPreferences
  }

  void _saveData() {
    _preferences.setInt("${widget.username}_likes", _likes);
    _preferences.setBool("${widget.username}_isLiked", _isLiked);
    _preferences.setStringList("${widget.username}_comments", _comments);
  }

  String getTime(String timeAgo) {
    DateTime parsedTime = DateTime.parse(timeAgo);

    DateTime currentTime = DateTime.now();

    Duration difference = currentTime.difference(parsedTime);
    int daysAgo = difference.inDays;

    if (daysAgo == 0) {
      return 'Today';
    } else if (daysAgo == 1) {
      return '1 day ago';
    } else {
      return '$daysAgo days ago';
    }
  }
}

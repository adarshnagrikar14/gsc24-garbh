// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:garbh/communityPage/postcard.dart';

class CommunityHomePage extends StatefulWidget {
  const CommunityHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CommunityHomePage>
    with SingleTickerProviderStateMixin {
  late FirebaseFirestore _firestore;
  late CollectionReference _postCollection;

  late List<String> textInContainer;

  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _postCollection = _firestore.collection('posts');

    textInContainer = [];

    _currentUser = FirebaseAuth.instance.currentUser;

    _fetchTips();
  }

  void _fetchTips() async {
    try {
      QuerySnapshot tipsSnapshot = await _firestore.collection('tips').get();
      List<String> tips =
          tipsSnapshot.docs.map((doc) => doc['content'] as String).toList();

      setState(() {
        textInContainer = tips;
      });
    } catch (e) {
      print('Error fetching tips: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _postCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var postData = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2.0,
                        color: Colors.red.shade50,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset(
                                "assets/images/community.jpg",
                                width: 90.0,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                              const Gap(18.0),
                              Expanded(
                                child: Text(
                                  "Find the helpful community posts and enjoy the way you want and share your joy to others...",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Gap(5.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    for (var post in postData)
                      PostContainer(
                        profileImagePath: post['profileImage'],
                        username: post['username'],
                        timeAgo: post['timeAgo'],
                        caption: post['caption'],
                        imagePath: post['imagePath'],
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(DateTime.now());

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              TextEditingController captionController = TextEditingController();
              // You can add more controllers for other fields if needed

              return AlertDialog(
                title: Text("Add Post"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: captionController,
                      decoration: InputDecoration(labelText: 'Caption'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      String caption = captionController.text;
                      try {
                        await FirebaseFirestore.instance
                            .collection('posts')
                            .add({
                          'profileImage': _currentUser?.photoURL,
                          'username': _currentUser?.displayName,
                          'timeAgo': "${DateTime.now()}",
                          'caption': caption,
                          'imagePath': "",
                        });
                        Navigator.of(context).pop();
                      } catch (e) {
                        print('Error uploading post: $e');
                      }
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.red.shade400,
        child: Icon(Icons.add),
      ),
    );
  }
}

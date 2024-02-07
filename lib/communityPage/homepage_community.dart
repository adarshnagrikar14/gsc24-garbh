// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garbh/communityPage/postcard.dart';

class CommunityHomePage extends StatefulWidget {
  const CommunityHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CommunityHomePage> {
  late FirebaseFirestore _firestore;
  late CollectionReference _postCollection;

  late List<String> imageUrls;
  late List<String> textInContainer;

  final List<LinearGradient> containerGradients = [
    const LinearGradient(
      colors: [
        Color.fromARGB(255, 249, 76, 102),
        Color.fromARGB(255, 119, 86, 195),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color.fromARGB(255, 249, 76, 102),
        Color.fromARGB(255, 119, 86, 195),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color.fromARGB(255, 249, 76, 102),
        Color.fromARGB(255, 119, 86, 195),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color.fromARGB(255, 249, 76, 102),
        Color.fromARGB(255, 119, 86, 195),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _postCollection = _firestore.collection('posts');

    imageUrls = List.generate(
      containerGradients.length,
      (index) => 'https://placehold.it/300x300',
    );

    textInContainer = [];

    _fetchImageUrls();
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

  void _fetchImageUrls() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('images').get();
      List<String> urls =
          snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();

      setState(() {
        imageUrls = urls;
      });
    } catch (e) {
      print('Error fetching image URLs: $e');
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: PageView.builder(
                        itemCount: containerGradients.length,
                        itemBuilder: (context, index) {
                          if (index < textInContainer.length) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 20),
                              decoration: BoxDecoration(
                                gradient: containerGradients[index],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Top Tips by the community",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      textInContainer[index],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        imageUrls[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Text('Learn More'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
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
    );
  }
}
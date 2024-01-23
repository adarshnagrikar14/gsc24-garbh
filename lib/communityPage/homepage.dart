import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garbh/communityPage/postcard.dart';

class CommunityHomePage extends StatefulWidget {
  const CommunityHomePage({Key? key}) : super(key: key);

  @override
  _CommunityHomePageState createState() => _CommunityHomePageState();
}

class _CommunityHomePageState extends State<CommunityHomePage> {
  final PageController _pageController = PageController();
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

<<<<<<< HEAD
  final List<String> textInContainer = [
    "    Ensure you get adequate rest and sleep. Pregnancy can be tiring, so listen to your body and rest when needed.",
    "Eat a well-balanced diet that includes a variety of fruits, vegetables, whole grains, lean proteins, and dairy.",
    "Practice good hygiene to prevent infections,Avoid exposure to harmful chemicals and toxins.",
    "Stay informed about the changes happening in your body and the development of your baby."
  ];
  final List<String> imagePaths = [
    "assets/images/strawberry.png",
    "assets/images/grape.png",
    "assets/images/kidney_bean.png",
    "assets/images/music_l.png"
  ];

  List<Map<String, dynamic>> postData = [
    {
      'profileImage': 'assets/images/grape.png',
      'username': 'Dr. Priyanka Sharma',
      'timeAgo': '2 hours ago',
      'caption':
          '    Maintain a healthy weight gain as recommended by your healthcare provider.',
      'imagePath': 'assets/images/grape.png',
    },
    {
      'profileImage': 'assets/images/grape.png',
      'username': 'Dr. Rakesh Verma',
      'timeAgo': '1 hour ago',
      'caption':
          'Take prenatal vitamins as recommended by your healthcare provider, including folic acid.',
      'imagePath': 'assets/images/avocado.png',
    },
    {
      'profileImage': 'assets/images/apple.png',
      'username': 'Poorvi Verma(Mother)',
      'timeAgo': '2 hours ago',
      'caption':
          'Take prenatal classes to learn about the labor and delivery process, it really helped me a lot',
      'imagePath': 'assets/images/grape.png',
    },
    {
      'profileImage': 'assets/images/strawberry.png',
      'username': 'Nitikesh Tiwari',
      'timeAgo': '7d ago',
      'caption':
          'My wife really had a hard period, but we managed to go through it.',
      'imagePath': 'assets/images/grape.png',
    },
    {
      'profileImage': 'assets/images/fig.png',
      'username': 'Aayushi Wankhede',
      'timeAgo': '1 month ago',
      'caption':
          'Invest in comfortable, loose-fitting maternity clothes that accommodate your growing belly.',
      'imagePath': 'assets/images/strawberry.png',
    },
    {
      'profileImage': 'assets/images/apple.png',
      'username': 'Aayushi Wankhede',
      'timeAgo': '1 month ago',
      'caption':
          'Invest in comfortable, loose-fitting maternity clothes that accommodate your growing belly.',
      'imagePath': 'assets/images/grape.png',
    },
  ];
=======
  int _selectedIndex = 0;
>>>>>>> 0864e7f (Community)

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _postCollection = _firestore.collection('posts');

    // Initialize imageUrls with placeholder URLs
    imageUrls = List.generate(
        containerGradients.length,
        (index) =>
            'https://placehold.it/300x300'); // Default image if URL is null

    // Initialize textInContainer as an empty list
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/communityAsset/background.jpg",
=======
      appBar: AppBar(
        elevation: 100,
        backgroundColor: const Color.fromARGB(255, 249, 76, 102),
        title: const Text(
          "Garbh Community Page",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _postCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var postData = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/communityAsset/background.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
>>>>>>> 0864e7f (Community)
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: PageView.builder(
                        controller: _pageController,
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
                            // Handle the case when the index is out of range
                            return Container(); // Or some default widget or an empty container
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

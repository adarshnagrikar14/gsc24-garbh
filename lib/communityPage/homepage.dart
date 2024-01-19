// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:garbh/communityPage/postcard.dart';

class CommunityHomePage extends StatefulWidget {
  const CommunityHomePage({Key? key}) : super(key: key);

  @override
  _CommunityHomePageState createState() => _CommunityHomePageState();
}

class _CommunityHomePageState extends State<CommunityHomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isCheckBoxChecked = false;

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

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < containerGradients.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
    Future.delayed(Duration.zero, () {
      _showWelcomePopup();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showWelcomePopup() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Welcome to the Garbh community!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Make sure you follow the guidelines related to the community.",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: _isCheckBoxChecked,
                          onChanged: (value) {
                            setState(() {
                              _isCheckBoxChecked = value!;
                            });
                          },
                        ),
                        const Text("I agree"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isCheckBoxChecked
                          ? () {
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: const Text("OK"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/communityAsset/background.jpg",
                ),
                fit: BoxFit.cover,
              ),
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
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 20),
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
                                child: Image.asset(
                                  imagePaths[index],
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
                    },
                  ),
                ),
                for (var post in postData)
                  PostContainer(
                    profileImagePath: post['profileImage']!,
                    username: post['username'],
                    timeAgo: post['timeAgo'],
                    caption: post['caption'],
                    imagePath: post['imagePath'],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

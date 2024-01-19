import 'package:flutter/material.dart';
import 'dart:async';

import 'package:garbh/communityPage/postcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    "assets/communityAsset/image1.jpg",
    "assets/communityAsset/image2.jpeg",
    "assets/communityAsset/image3.jpg",
    "assets/communityAsset/image4.jpg"
  ];

  int _selectedIndex = 0;

  List<Map<String, dynamic>> postData = [
    {
      'profileImage': 'assets/communityAsset/image1.jpg',
      'username': 'Dr. Priyanka Sharma',
      'timeAgo': '2 hours ago',
      'caption':
          '    Maintain a healthy weight gain as recommended by your healthcare provider.',
      'imagePath': 'assets/communityAsset/image1.jpg',
    },
    {
      'profileImage': 'assets/communityAsset/image1.jpg',
      'username': 'Dr. Rakesh Verma',
      'timeAgo': '1 hour ago',
      'caption':
          'Take prenatal vitamins as recommended by your healthcare provider, including folic acid.',
      'imagePath': 'assets/communityAsset/image2.jpeg',
    },
    {
      'profileImage': 'assets/communityAsset/image1.jpg',
      'username': 'Poorvi Verma(Mother)',
      'timeAgo': '2 hours ago',
      'caption':
          'Take prenatal classes to learn about the labor and delivery process, it really helped me a lot',
      'imagePath': 'assets/communityAsset/image1.jpg',
    },
    {
      'profileImage': 'assets/communityAsset/image1.jpg',
      'username': 'Nitikesh Tiwari',
      'timeAgo': '7d ago',
      'caption':
          'My wife really had a hard period, but we managed to go through it.',
      'imagePath': 'assets/communityAsset/image2.jpeg',
    },
    {
      'profileImage': 'assets/communityAsset/image1.jpg',
      'username': 'Aayushi Wankhede',
      'timeAgo': '1 month ago',
      'caption':
          'Invest in comfortable, loose-fitting maternity clothes that accommodate your growing belly.',
      'imagePath': 'assets/communityAsset/image2.jpeg',
    },
    {
      'profileImage': 'assets/communityAsset/image1.jpg',
      'username': 'Aayushi Wankhede',
      'timeAgo': '1 month ago',
      'caption':
          'Invest in comfortable, loose-fitting maternity clothes that accommodate your growing belly.',
      'imagePath': 'assets/communityAsset/image2.jpeg',
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
      appBar: AppBar(
        elevation: 100,
        backgroundColor: const Color.fromARGB(255, 249, 76, 102),
        title: const Text(
          "Garbh Community Page",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 34, 33, 33),
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: const Color.fromARGB(255, 249, 76, 102),
      ),
    );
  }
}

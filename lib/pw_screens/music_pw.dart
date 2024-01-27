import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:garbh/data/music_data.dart';

class MusicListeningScreen extends StatefulWidget {
  const MusicListeningScreen({super.key});

  @override
  State<MusicListeningScreen> createState() => _MusicListeningScreenState();
}

class _MusicListeningScreenState extends State<MusicListeningScreen> {
  Color redColor = const Color.fromARGB(255, 249, 76, 102);

  List<Map<String, List<String>>> musicData = musicDatas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Relaxing Music...",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: redColor,
        toolbarHeight: 60.0,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: musicDatas.length,
        itemBuilder: (context, index) {
          var music = musicDatas[index].values.first;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2.0,
              child: GestureDetector(
                onTap: () => _showBottomSheet(context, music),
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                    left: 12,
                    right: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.asset(
                          "assets/images/music_l.png",
                          width: 80.0,
                          height: 80.0,
                        ),
                      ),
                      const Gap(5.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              music[0],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(6.0),
                            Text(
                              'Source: ${music[2]}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context, List<String> musicData) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.red.shade50,
      backgroundColor: Colors.red.shade50,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(12),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                musicData[0],
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Play Music"),
              ),
            ],
          ),
        );
      },
    );
  }
}

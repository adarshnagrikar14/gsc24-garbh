import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:garbh/data/alpha_data.dart';

class AlphaMusicPage extends StatefulWidget {
  const AlphaMusicPage({super.key});

  @override
  State<AlphaMusicPage> createState() => _AlphaMusicPageState();
}

class _AlphaMusicPageState extends State<AlphaMusicPage> {
  Color redColor = const Color.fromARGB(255, 249, 76, 102);

  List<Map<String, List<String>>> musicData = alphaMusicDatas;

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
        itemCount: alphaMusicDatas.length,
        itemBuilder: (context, index) {
          var music = alphaMusicDatas[index].values.first;

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
                          "assets/images/lullaby.png",
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
    AudioPlayer audioPlayer = AudioPlayer();
    String isPlaying = "";

    showModalBottomSheet(
      context: context,
      barrierColor: Colors.red.shade50,
      backgroundColor: Colors.red.shade50,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${musicData[0]} 🎵",
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20.0),
                    Card(
                      child: Image.asset(
                        "assets/images/lullaby.png",
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 150.0,
                      ),
                    ),
                    const Gap(15.0),
                    Text(isPlaying),
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: LinearProgressIndicator(),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await audioPlayer.play(
                          AssetSource(musicData[1]),
                        );

                        setState(
                          () {
                            isPlaying = "Playing...";
                          },
                        );
                      },
                      child: const Text("Play Music"),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      audioPlayer.stop();
      audioPlayer.dispose();
    });
  }
}

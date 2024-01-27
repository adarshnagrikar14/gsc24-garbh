import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:garbh/data/podcast_data.dart';
import 'package:garbh/reusables/custom_pod_card.dart';
import 'package:url_launcher/url_launcher.dart';

class PodcastPage extends StatefulWidget {
  const PodcastPage({super.key});

  @override
  State<PodcastPage> createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  Color redColor = const Color.fromARGB(255, 249, 76, 102);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Podcast",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: redColor,
        toolbarHeight: 60.0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                elevation: 2.0,
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
                        "assets/images/podcast.png",
                        width: 90.0,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                      const Gap(18.0),
                      Expanded(
                        child: Text(
                          "Listen to the latest podcasts specially curated for you to enjoy... ",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      const Gap(5.0),
                    ],
                  ),
                ),
              ),
              const Gap(20.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: podcastDatas.length,
                itemBuilder: (context, index) {
                  var podcast = podcastDatas[index].values.first;
                  return CustomCard(
                    imageUrl: podcast[2],
                    title: podcast[0],
                    channelName: podcast[1],
                    onTap: () => _launchInBrowser(Uri.parse(podcast[3])),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

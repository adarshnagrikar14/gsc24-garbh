import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:garbh/data/podcast_data.dart';
import 'package:garbh/reusables/custom_pod_card.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class GrowthTrackerPage extends StatefulWidget {
  const GrowthTrackerPage({super.key});

  @override
  State<GrowthTrackerPage> createState() => _GrowthTrackerPageState();
}

class _GrowthTrackerPageState extends State<GrowthTrackerPage> {
  String zScoreHeightGirlsBto2 =
      "https://drive.google.com/file/d/1afiM4LTFIbD7gCrqd3GbZkb6xmhSZzXa/view?usp=drive_link";
  String zScoreHeightBoysBto2 =
      "https://drive.google.com/file/d/1nQxgZt3dAjUT8bxzDiF3VoNObbSx8npM/view?usp=drive_link";
  String zScoreWeightBoysBto2 =
      "https://drive.google.com/file/d/1kMg-EL5ZlLbHHCYrPKgH5lK-4_Ske4VY/view?usp=drive_link";
  String zScoreWeightGirlsBto2 =
      "https://drive.google.com/file/d/1NQqNfZTWr6P2t7-ud4U-yQ3Mi-BcKh-X/view?usp=drive_link";

  String standardReferenceWHO =
      "https://www.who.int/tools/child-growth-standards/standards";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track Child Growth",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 249, 76, 102),
        toolbarHeight: 60.0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                elevation: 2.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        "assets/images/child_growth.png",
                        width: 90.0,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                      const Gap(10.0),
                      const Expanded(
                        child: Text(
                          "Find the Child growth track along with the growth data by WHO. Please note that the individual child growth maybe different from the statistics.",
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
              const Gap(20.0),
              const Text(
                "WHO References for child Growth",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10.0),
              CustomListTile(
                title:
                    "Girls chart- Length for age: birth to 2 years (z-scores)",
                subtitle: zScoreHeightGirlsBto2,
                onTap: () => _launchInBrowser(Uri.parse(zScoreHeightGirlsBto2)),
              ),
              CustomListTile(
                title:
                    "Boys chart- Length for age: birth to 2 years (z-scores)",
                subtitle: zScoreHeightBoysBto2,
                onTap: () => _launchInBrowser(Uri.parse(zScoreHeightBoysBto2)),
              ),
              CustomListTile(
                title:
                    "Girls chart- Weight-for-age: Birth to 2 years (z-scores)",
                subtitle: zScoreWeightGirlsBto2,
                onTap: () => _launchInBrowser(Uri.parse(zScoreWeightGirlsBto2)),
              ),
              CustomListTile(
                title:
                    "Boys chart- Weight-for-age: Birth to 2 years (z-scores)",
                subtitle: zScoreWeightBoysBto2,
                onTap: () => _launchInBrowser(Uri.parse(zScoreWeightBoysBto2)),
              ),

              //
              const Gap(20.0),
              const Text(
                "Development Track",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10.0),
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
                    onTap: () {},
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

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        child: ListTile(
          leading: const Icon(
            LineIcons.link,
          ),
          title: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            children: [
              const Gap(10.0),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(5.0),
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

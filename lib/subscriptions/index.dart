import 'package:flutter/material.dart';
import 'package:hear2learn/common/vertical_list_view.dart';

// TODO: remove
class DownloadedPodcastDetails {
  String name;
  String description;
  Image image;
  int numEpisodesDownloaded;

  DownloadedPodcastDetails(
    this.name,
    this.description,
    this.image,
    this.numEpisodesDownloaded
  );
}

// TODO: remove
List<DownloadedPodcastDetails> sampleData = [
  DownloadedPodcastDetails(
    "Ellen on the Go",
    "Ellen on the Go is the place to hear what they\'re talking about on the Ellen Degeneres Show! Hosted by the show\'s Executive Producers, Ed, Mary, Andy and Kevin, this is your audio catch-up of this week\'s Ellen Show, with a never-before-experienced glimpse at how the talk show comes together every day from the very minds that make it happen.",
    Image.network("https://content.production.cdn.art19.com/images/04/3a/fd/ae/043afdae-cf15-4bc5-8522-e0dc522f4cfc/690d7a0f71063143cd34fc294012c53e28e31cd410df0f7b99e20939237371881a55a864d7cb9db35094d8737b07bc2b92111c26e1796d203bf777049225667c.jpeg"),
    3
  ),
  DownloadedPodcastDetails(
    "The Good Place: The Podcast",
    "Holy motherforking shirtballs! This is the official comedy and entertainment podcast for NBC\'s TV show The Good Place. Subscribe and you\'ll get weekly behind-the-scenes stories, episode and performance insights and funny anecdotes. Hosted by actor Marc Evan Jackson (Shawn) with a rotating slate of co-hosts and special guests, including actors, writers, producers and more, this podcast takes a deep dive into everything on- and off-screen.",
    Image.network("https://content.production.cdn.art19.com/images/e8/49/ce/1f/e849ce1f-f43e-4e73-968e-0eca212d2ed6/5549071b8e91edc4dd373526df7cd64d6289c12808e632e2afece7e0258979c0cd5e5848a8e86eebd1e6ebeea8681ac37a23e87c01ade7584ed0bb4480997f06.jpeg"),
    1
  ),
  DownloadedPodcastDetails(
    "The Daily Show With Trevor Noah: Ears Edition",
    "Listen to highlights and extended interviews in the \"Ears Edition\" of The Daily Show with Trevor Noah. From Comedy Central\'s Podcast Network.",
    Image.network("https://content.production.cdn.art19.com/images/bd/0b/58/94/bd0b5894-05c5-42c0-910f-8f72e00006b1/e8439cdf81cbe454191c0d23ebba7e1a35e90d7cac14e411bbbd6ebf86ac3bd9d9e79f8cfcf8d07aa4b490658010044771ff51763fee14b30220509cc3a22946.jpeg"),
    2
  ),
  DownloadedPodcastDetails(
    "Star Talk",
    "Science, pop culture and comedy collide on StarTalk Radio! Astrophysicist and Hayden Planetarium director Neil deGrasse Tyson, his comic co-hosts, guest celebrities and scientists discuss astronomy, physics, and everything else about life in the universe. Keep Looking Up! New episodes premiere Friday nights at 7pm ET.",
    Image.network("https://content.production.cdn.art19.com/images/ea/bf/ce/0f/eabfce0f-4d38-4600-b5b9-3e0043b94987/e76f68f407f76ddc2b497f144e037abfe10216f49cae2716c5e174f705b1c05d83f0ff7082da9d6180d42d5a999d7979a140becf59cdc0b91aeaa0e0906793e5.jpeg"),
    2
  ),
  DownloadedPodcastDetails(
    "Dr. Death",
    "We\'re at our most vulnerable when we go to our doctors. We trust the person at the other end of that scalpel. We trust the hospital. We trust the system. Christopher Duntsch was a neurosurgeon who radiated confidence. He claimed he was the best in Dallas. If you had back pain, and had tried everything else, Dr. Duntsch could give you the spine surgery that would take your pain away.",
    Image.network("https://content.production.cdn.art19.com/images/1d/53/8f/a0/1d538fa0-4053-481a-bc95-55b0df8d4b6a/7b5c4d189c1de41d09336dce75b6ff3be53031429822a666584b07b745c1881005b3ea8612048df9207741f9298e1d784da946fc98f373e2c8c3097694a0efc8.jpeg"),
    2
  ),
  DownloadedPodcastDetails(
    "ID10T with Chris Hardwick",
    "I am Chris Hardwick. This podcast used to be called Nerdist. Now it is not. It is still basically just me talking about stuff and things with my two nerdy friends Jonah Ray and Matt Mira when they\'re available, and usually someone more famous and smarter than all of us. Swearing is still fun, so we still do that occasionally. I hope you like this new iteration which is the same as before, but if a name hangs you up unhealthily I\'m sure you will not hesitate to unfurl your rage not only in the ‘reviews\' section but also now on all the various social media platforms that have popped up since we started in 2010, effectively murdering blogs.",
    Image.network("https://content.production.cdn.art19.com/images/58/a1/cf/f4/58a1cff4-2127-476f-a386-eb043b863a7a/fb3ae239ce76e71eb5c71e73c2599b185b3afa215fec998b7e80c79a329ab63a3d722f42cba430910a265f720f33636129747921d1fb2fe0f85fcd528b2db0c5.jpeg"),
    5
  ),
  DownloadedPodcastDetails(
    "Inquiring Minds",
    "Each week Inquiring Minds brings you a new, in-depth exploration of the space where science, politics, and society collide.",
    Image.network("https://content.production.cdn.art19.com/images/23/03/80/cf/230380cf-4cfc-4e16-8d76-c0c172d99068/4f113020ab8d7ea51fb6bf628c294504b60658edf31fa457963270eca414ae339e0514ba6f94ca1676bbdd851ac945e7328915b196e4eb302f62f6df84d12d21.jpeg"),
    4
  ),
  DownloadedPodcastDetails(
    "Today, Explained",
    "News comes at you fast. Join us at the end of your day to understand it. Monday to Friday. All killer, no filler. Hosted by Sean Rameswaram. Featuring the finest explainers from Vox and more. Produced by Vox and Stitcher, and part of the Vox Media Podcast Network.",
    Image.network("https://content.production.cdn.art19.com/images/bb/ae/09/4a/bbae094a-2155-4d58-982d-de9dfcfe85ca/55e801beccc45e3cdb857bae3d179f37b5c75c1a2b5737362b925426291f053dee31948f7c7f173e5d64b3b739ecaa31e22741aae8de6d4cbdcd94ac0da7a346.jpeg"),
    4
  ),
];

class SubscriptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Podcasts')
        ),
        body: Container(
          child: VerticalListView(
            children: sampleData.map((item) => VerticalListTile(
              image: item.image,
              subtitle: item.description,
              title: item.name,
            )).toList(),
          ),
          padding: EdgeInsets.all(16.0),
        ),
      ),
      length: 3,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hear2learn/download/downloaded_podcast_tile.dart';

class DownloadPage extends StatelessWidget {
  String url;

  DownloadPage({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Downloaded Podcasts')
        ),
        body: ListView(
          children: [
            Container(
              child: DownloadedPodcastTile(
                image: Image.network('https://content.production.cdn.art19.com/images/ea/bf/ce/0f/eabfce0f-4d38-4600-b5b9-3e0043b94987/e76f68f407f76ddc2b497f144e037abfe10216f49cae2716c5e174f705b1c05d83f0ff7082da9d6180d42d5a999d7979a140becf59cdc0b91aeaa0e0906793e5.jpeg'),
                numDownloads: 3,
                subtitle: "Ellen on the Go is the place to hear what they’re talking about on the Ellen Degeneres Show! Hosted by the show’s Executive Producers, Ed, Mary, Andy and Kevin, this is your audio catch-up of this week’s Ellen Show, with a never-before-experienced glimpse at how the talk show comes together every day from the very minds that make it happen.",
                title: 'Ellen on the Go',
              ),
              margin: const EdgeInsets.only(bottom: 8.0),
            ),
            Container(
              child: DownloadedPodcastTile(
                image: Image.network('https://content.production.cdn.art19.com/images/e8/49/ce/1f/e849ce1f-f43e-4e73-968e-0eca212d2ed6/5549071b8e91edc4dd373526df7cd64d6289c12808e632e2afece7e0258979c0cd5e5848a8e86eebd1e6ebeea8681ac37a23e87c01ade7584ed0bb4480997f06.jpeg'),
                numDownloads: 1,
                subtitle: "Holy motherforking shirtballs! This is the official comedy and entertainment podcast for NBC's TV show The Good Place. Subscribe and you'll get weekly behind-the-scenes stories, episode and performance insights and funny anecdotes. Hosted by actor Marc Evan Jackson (Shawn) with a rotating slate of co-hosts and special guests, including actors, writers, producers and more, this podcast takes a deep dive into everything on- and off-screen.",
                title: 'The Good Place: The Podcast',
              ),
              margin: const EdgeInsets.only(bottom: 8.0),
            ),
            Container(
              child: DownloadedPodcastTile(
                image: Image.network('https://content.production.cdn.art19.com/images/bd/0b/58/94/bd0b5894-05c5-42c0-910f-8f72e00006b1/e8439cdf81cbe454191c0d23ebba7e1a35e90d7cac14e411bbbd6ebf86ac3bd9d9e79f8cfcf8d07aa4b490658010044771ff51763fee14b30220509cc3a22946.jpeg'),
                numDownloads: 1,
                subtitle: 'Listen to highlights and extended interviews in the "Ears Edition" of The Daily Show with Trevor Noah. From Comedy Central’s Podcast Network.',
                title: 'The Daily Show With Trevor Noah: Ears Edition',
              ),
              margin: const EdgeInsets.only(bottom: 8.0),
            ),
          ],
          shrinkWrap: true,
        ),
      ),
      length: 3,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hear2learn/common/episode_tile.dart';

Widget mockEpisodeImage = Image.asset("images/fff.png");

class PodcastEpisodesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            child: EpisodeTile(
              image: mockEpisodeImage,
              subtitle: 'Added: 2d ago. Duration: 50m.',
              title: 'Azure Functions and CosmosDB',
              options: Column(
                children: [
                  IconButton(icon: Icon(Icons.get_app)),
                  Text('32mb'),
                ],
              ),
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
          Container(
            child: EpisodeTile(
              image: mockEpisodeImage,
              subtitle: 'Added: 9d ago. Duration: 40m.',
              title: 'Containerization with Docker',
              options: Column(
                children: [
                  IconButton(icon: Icon(Icons.get_app)),
                  Text('32mb'),
                ],
              ),
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
        ],
        shrinkWrap: true,
      ),
    );
  }
}

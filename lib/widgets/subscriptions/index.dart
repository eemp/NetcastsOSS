import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/placeholder_screen.dart';
import 'package:hear2learn/widgets/common/vertical_list_view.dart';
import 'package:hear2learn/widgets/common/with_fade_in_image.dart';
import 'package:hear2learn/widgets/podcast/index.dart';

class SubscriptionsPage extends StatelessWidget {
  final App app = App();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Podcasts'),
      ),
      body: StoreConnector<AppState, List<Podcast>>(
        converter: subscriptionsSelector,
        builder: (BuildContext context, List<Podcast> subscriptions) {
          return subscriptions.isNotEmpty
            ? Container(
                child: VerticalListView(
                  children: subscriptions.map((Podcast podcast) {
                    final Widget image = WithFadeInImage(
                      heroTag: 'subscriptions/${podcast.artwork600}',
                      location: podcast.artwork600,
                    );
                    return VerticalListTile(
                      image: image,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => PodcastPage(
                              directToEpisodes: true,
                              image: image,
                              podcast: podcast,
                            )
                          ),
                        );
                      },
                      //subtitle: podcast.description,
                      subtitle: podcast.getByline(),
                      title: podcast.name,
                    );
                  }).toList(),
                ),
                padding: const EdgeInsets.all(16.0),
              )
              : const PlaceholderScreen(
                icon: Icons.subscriptions,
                subtitle: 'Subscribe to podcasts and find them here.',
                title: 'No podcasts subscriptions yet',
              );
        },
      ),
      bottomNavigationBar: const BottomAppBarPlayer(),
    );
  }
}

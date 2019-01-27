import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/placeholder_screen.dart';
import 'package:hear2learn/widgets/common/vertical_list_view.dart';
import 'package:hear2learn/widgets/common/with_fade_in_image.dart';
import 'package:hear2learn/widgets/podcast/index.dart';

class SubscriptionsPage extends StatefulWidget {
  @override
  SubscriptionsPageState createState() => SubscriptionsPageState();
}

class SubscriptionsPageState extends State<SubscriptionsPage> {
  final App app = App();
  Future<List<Podcast>> subscriptionsFuture;

  @override
  Widget build(BuildContext context) {
    final PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
    final Future<List<Podcast>> subscriptionsFuture = subscriptionModel.findWhere(subscriptionModel.isSubscribed.eq(true)).then(
      (List<PodcastSubscription> response) =>
        Future.wait(response.map((PodcastSubscription subscription) => Future<Podcast>.value(subscription.getPodcastFromDetails())))
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Podcasts'),
      ),
      body: FutureBuilder<List<Podcast>>(
        future: subscriptionsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
          if(!snapshot.hasData) {
            return Container(
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          return snapshot.data.isNotEmpty
            ? Container(
                child: VerticalListView(
                  children: snapshot.data.map((Podcast podcast) {
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

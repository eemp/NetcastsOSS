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
    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
    subscriptionsFuture = subscriptionModel.findWhere(subscriptionModel.isSubscribed.eq(true)).then((response) {
      return Future.wait(response.map((subscription) => Future.value(subscription.getPodcastFromDetails())));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Podcasts')
      ),
      body: FutureBuilder(
        future: subscriptionsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
          if(!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return snapshot.data.isNotEmpty
            ? Container(
                child: VerticalListView(
                  children: snapshot.data.map((podcast) {
                    Widget image = WithFadeInImage(
                      heroTag: 'subscriptions/${podcast.artwork600}',
                      location: podcast.artwork600,
                    );
                    return VerticalListTile(
                      image: image,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PodcastPage(
                            image: image,
                            podcast: podcast,
                          )),
                        );
                      },
                      //subtitle: podcast.description,
                      subtitle: podcast.getByline(),
                      title: podcast.name,
                    );
                  }).toList(),
                ),
                padding: EdgeInsets.all(16.0),
              )
              : PlaceholderScreen(
                icon: Icons.subscriptions,
                subtitle: 'Subscribe to podcasts and find them here.',
                title: 'No podcasts subscriptions yet',
              );
        },
      ),
      bottomNavigationBar: BottomAppBarPlayer(),
    );
  }
}

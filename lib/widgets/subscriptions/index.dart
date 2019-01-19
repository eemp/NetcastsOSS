import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/widgets/common/vertical_list_view.dart';
import 'package:hear2learn/widgets/common/with_fade_in_image.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/services/feeds/podcast.dart';
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
      return Future.wait(response.map((subscription) => getPodcastFromFeed(subscription.podcastUrl)));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Podcasts')
      ),
      body: FutureBuilder(
        future: subscriptionsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
          return snapshot.hasData
            ? Container(
                child: VerticalListView(
                  children: snapshot.data.map((podcast) {
                    Widget image = WithFadeInImage(
                      heroTag: 'subscriptions/${podcast.logoUrl}',
                      location: podcast.logoUrl,
                    );
                    return VerticalListTile(
                      image: image,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PodcastPage(
                            image: image,
                            logoUrl: podcast.logoUrl,
                            title: podcast.title,
                            url: podcast.url,
                          )),
                        );
                      },
                      subtitle: podcast.description,
                      title: podcast.title,
                    );
                  }).toList(),
                ),
                padding: EdgeInsets.all(16.0),
              )
            : Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            );
        },
      ),
      bottomNavigationBar: BottomAppBarPlayer(),
    );
  }
}

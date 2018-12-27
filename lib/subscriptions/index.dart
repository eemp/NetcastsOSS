import 'package:flutter/material.dart';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/common/vertical_list_view.dart';
import 'package:hear2learn/common/with_fade_in_image.dart';
import 'package:hear2learn/models/podcast_subscription.dart';
import 'package:hear2learn/podcast/index.dart';
import 'package:swagger/api.dart';

class SubscriptionsPage extends StatelessWidget {
  final App app = App();
  final PodcastApi podcastApiService = new PodcastApi();

  @override
  Widget build(BuildContext context) {
    PodcastSubscriptionBean subscriptionModel = app.models['podcast_subscription'];
    Future<List<Podcast>> subscriptionsFuture = subscriptionModel.findWhere(subscriptionModel.isSubscribed.eq(true)).then((response) {
      return Future.wait(response.map((subscription) => podcastApiService.getPodcast(subscription.podcastUrl)));
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
                  children: snapshot.data.map((podcast) => VerticalListTile(
                    image: WithFadeInImage(location: podcast.scaledLogoUrl),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PodcastPage(
                          url: podcast.url,
                        )),
                      );
                    },
                    subtitle: podcast.description,
                    title: podcast.title,
                  )).toList(),
                ),
                padding: EdgeInsets.all(16.0),
              )
            : Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:share/share.dart';

class PodcastOptions extends StatelessWidget {
  final Function onSubscribe;
  final Function onUnsubscribe;
  final Podcast podcast;

  const PodcastOptions({
    Key key,
    this.onSubscribe,
    this.onUnsubscribe,
    this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildSubscriptionButton(),
        buildShareOptions(),
      ],
    );
  }

  Widget buildSubscriptionButton() {
    return StoreConnector<AppState, Podcast>(
      converter: getSubscriptionSelector(podcast),
      builder: (BuildContext context, Podcast subscription) {
        final bool isSubscribed = subscription != null;

        return !isSubscribed
          ? buildSubscribeOption()
          : buildUnsubscribeOption()
          ;
      },
    );
  }

  Widget buildSubscribeOption() {
    return FlatButton.icon(
      icon: const Icon(Icons.add),
      label: const Text('Subscribe'),
      onPressed: onSubscribe,
    );
  }

  Widget buildUnsubscribeOption() {
    return FlatButton.icon(
      icon: const Icon(Icons.remove),
      label: const Text('Unsubscribe'),
      onPressed: onUnsubscribe,
    );
  }

  Widget buildShareOptions() {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () {
        Share.share('Check out ${podcast.name} podcast, courtesy of ${podcast.artist.name}');
      },
      tooltip: 'Share',
    );
  }
}

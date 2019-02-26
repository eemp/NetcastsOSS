import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/outline_icon_button.dart';

class PodcastOptions extends StatelessWidget {
  final Function onShare;
  final Function onSubscribe;
  final Function onUnsubscribe;
  final Podcast podcast;

  const PodcastOptions({
    Key key,
    this.onShare,
    this.onSubscribe,
    this.onUnsubscribe,
    this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: buildSubscriptionButton(),
          margin: const EdgeInsets.only(right: 16.0),
        ),
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
    return OutlineButton.icon(
      icon: const Icon(Icons.add),
      label: const Text('Subscribe'),
      onPressed: onSubscribe,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
    );
  }

  Widget buildUnsubscribeOption() {
    return RaisedButton.icon(
      icon: const Icon(Icons.done),
      label: const Text('Subscribed'),
      onPressed: onUnsubscribe,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
    );
  }

  Widget buildShareOptions() {
    return OutlineIconButton(
      icon: Icons.share,
      onPressed: onShare,
    );
  }
}

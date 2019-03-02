import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/run_app.dart';

Future<void> main() async {
  final App app = App();
  await app.init(
    //elasticHost: 'hear2learn.azurewebsites.net',
    elasticHost: 'qjrddhgpbq:41vtfspb70@podcasts-9232921312.us-east-1.bonsaisearch.net',
  );

  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final FirebaseAnalyticsObserver analyticsObserver =
      FirebaseAnalyticsObserver(analytics: analytics);

  await start(
    navigatorObservers: <NavigatorObserver>[
      app.store.state.settings.privacySetting ? analyticsObserver : null,
    ].where((NavigatorObserver observer) => observer != null).toList(),
  );
}

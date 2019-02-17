import 'dart:async';

import 'package:hear2learn/app.dart';
import 'package:hear2learn/run_app.dart';

Future<void> main() async {
  final App app = App();
  await app.init(
    //elasticHost: 'hear2learn.azurewebsites.net',
    elasticHost: 'qjrddhgpbq:41vtfspb70@podcasts-9232921312.us-east-1.bonsaisearch.net',
  );

  await start();
}

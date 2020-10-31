import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/helpers/dash.dart' as dash;
import 'package:just_audio/just_audio.dart';

MediaControl playControl = MediaControl(
  androidIcon: 'drawable/ic_action_play_arrow',
  label: 'Play',
  action: MediaAction.play,
);
MediaControl pauseControl = MediaControl(
  androidIcon: 'drawable/ic_action_pause',
  label: 'Pause',
  action: MediaAction.pause,
);

var _playbackStateSubscription;
Future<void> initAudioService(Function onPlaybackStateUpdateCallback) async {
  final App app = App();

  if(AudioService.running) {
    return Future.value();
  }

  await AudioService.connect();
  await AudioService.start(
    androidNotificationChannelName: 'Netcasts OSS Audio',
    androidStopOnRemoveTask: true,
    // androidNotificationIcon: 'mipmap/launcher_icon',
    backgroundTaskEntrypoint: backgroundAudioPlayerTask,
    enableQueue: true,
    notificationColor: 0xFF2196f3,
    resumeOnClick: true,
  );

  if(_playbackStateSubscription != null) {
    _playbackStateSubscription.cancel();
  }
  _playbackStateSubscription = AudioService.playbackStateStream.listen(onPlaybackStateUpdateCallback);
}

void backgroundAudioPlayerTask() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  List<MediaItem> _queue = <MediaItem>[];
  int _queueIndex = -1;
  AudioPlayer _audioPlayer = new AudioPlayer();
  Completer _completer = Completer();
  bool _playing = false;

  bool get hasNext => _queueIndex + 1 < _queue.length;

  bool get hasPrevious => _queueIndex > 0;

  MediaItem get mediaItem => _queue[_queueIndex];
  void set mediaItem(MediaItem updatedItem) {
    _queue[_queueIndex] = updatedItem;
  }

  BasicPlaybackState _stateToBasicState(AudioPlaybackState state) {
    switch (state) {
      case AudioPlaybackState.none:
        return BasicPlaybackState.none;
      case AudioPlaybackState.stopped:
        return BasicPlaybackState.stopped;
      case AudioPlaybackState.paused:
        return BasicPlaybackState.paused;
      case AudioPlaybackState.playing:
        return BasicPlaybackState.playing;
      case AudioPlaybackState.connecting:
        return BasicPlaybackState.connecting;
      case AudioPlaybackState.completed:
        return BasicPlaybackState.stopped;
      default:
        throw Exception("Illegal state");
    }
  }

  @override
  Future<void> onStart() async {
    var playerPositionSubscription = _audioPlayer.getPositionStream().listen((position) {
      _setState(
        position: position.inMilliseconds,
      );
    });
    var playerStateSubscription = _audioPlayer.playbackStateStream
        .where((state) => state == AudioPlaybackState.completed)
        .listen((state) {
      _handlePlaybackCompleted();
    });
    var eventSubscription = _audioPlayer.playbackEventStream.listen((event) {
      final state = _stateToBasicState(event.state);
      if (state != BasicPlaybackState.stopped) {
        _setState(
          state: state,
          position: event.position.inMilliseconds,
        );
      }
    });

    AudioServiceBackground.setQueue(_queue);
    await _completer.future;
    playerPositionSubscription.cancel();
    playerStateSubscription.cancel();
    eventSubscription.cancel();
  }

  void _handlePlaybackCompleted() {
    onStop();
  }

  void playPause() {
    if (AudioServiceBackground.state.basicState == BasicPlaybackState.playing)
      onPause();
    else
      onPlay();
  }

  @override
  void onPlay() {
    final AudioPlaybackState currentState = _audioPlayer.playbackState;

    _playing = true;
    if(currentState != AudioPlaybackState.connecting && currentState != AudioPlaybackState.none) {
      _audioPlayer.play();
    }
  }

  @override
  void onPause() {
    final AudioPlaybackState currentState = _audioPlayer.playbackState;

    _playing = false;
    if(currentState == AudioPlaybackState.playing) {
      _audioPlayer.pause();
    }
  }

  @override
  void onSeekTo(int position) {
    _audioPlayer.seek(Duration(milliseconds: position));
  }

  @override
  void onClick(MediaButton button) {
    playPause();
  }

  @override
  void onStop() {
    _audioPlayer.stop();
    _setState(state: BasicPlaybackState.stopped);
    _completer.complete();
  }

  @override
  Future<void> onAddQueueItem(MediaItem mediaItem) async {
    _queue.add(mediaItem);
    await AudioServiceBackground.setQueue(_queue);
  }

  @override
  Future<void> onCustomAction(String action, dynamic args) async {
    switch (action) {
      case 'loadAndPlayMedia':
        final Map mediaArgs = args;
        final Map mediaItemParams = args['mediaItem'];
        final int position = args['position'];

        final AudioPlaybackState currentState = _audioPlayer.playbackState;
        if(currentState == AudioPlaybackState.completed
            || currentState == AudioPlaybackState.playing
            || currentState == AudioPlaybackState.paused) {
          _audioPlayer.stop();
        }

        // try to make the duration stick
        Duration duration = await _audioPlayer.setFilePath(mediaItemParams['path']);
        final MediaItem mediaItem = MediaItem(
          album: mediaItemParams['album'],
          artist: mediaItemParams['artist'],
          duration: duration?.inMilliseconds,
          // artwork: matchingEpisode.podcast?.artwork100,
          id: mediaItemParams['path'],
          title: mediaItemParams['title'],
        );

        if(position != null) {
          await _audioPlayer.seek(Duration(milliseconds: position));
        }

        onPlay();

        AudioServiceBackground.setMediaItem(mediaItem);

        break;
    }
  }

  void _setState({BasicPlaybackState state, int position}) {
    if(position == null) {
      position = _audioPlayer.playbackEvent.position.inMilliseconds;
    }
    if(state == null) {
      state = _stateToBasicState(_audioPlayer.playbackEvent.state);
    }
    AudioServiceBackground.setState(
      systemActions: [MediaAction.seekTo],
      controls: getControls(state),
      basicState: state,
      position: position,
    );
  }

  List<MediaControl> getControls(BasicPlaybackState state) {
    return [
      _playing ? pauseControl : playControl,
    ];
  }
}

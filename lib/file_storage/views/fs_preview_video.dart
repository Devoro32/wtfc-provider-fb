import 'package:wtfc_provider_app/export.dart';

//! errror playing the video, please see note at the bottom
class FSPreviewVideo extends StatefulWidget {
  final String videoUrl;
  const FSPreviewVideo({
    super.key,
    required this.videoUrl,
  });

  @override
  State<FSPreviewVideo> createState() => _FSPreviewVideoState();
}

class _FSPreviewVideoState extends State<FSPreviewVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
    //   ..initialize().then((_) {
    //     setState(() {});
    //   });
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _controller.initialize();

    print('Parsing the url ${Uri.parse(widget.videoUrl)}');

    print('Controller detail: ${_controller}');
    print('video url: ${widget.videoUrl}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Preview'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(
                child: Text(
                    'Nothing here to see because intialized is false: ${_controller.value.isInitialized}'),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}


/*


W/ProviderInstaller(27871): Failed to load providerinstaller module: No acceptable module com.google.android.gms.providerinstaller.dynamite found. Local version is 0 and remote version is 0.
W/ProviderInstaller(27871): Failed to report request stats: com.google.android.gms.common.security.ProviderInstallerImpl.reportRequestStats [class android.content.Context, long, long]
D/EGL_emulation(27871): app_time_stats: avg=284.59ms min=11.02ms max=1359.20ms count=6
D/TrafficStats(27871): tagSocket(157) with statsTag=0xffffffff, statsUid=-1
I/flutter (27871): Parsing the url https://res.cloudinary.com/dygfufopy/raw/upload/v1738775820/r57oejuigmyeiqiuswsu.mp4
I/flutter (27871): Controller detail: VideoPlayerController#7531f(VideoPlayerValue(duration: 0:00:00.000000, size: Size(0.0, 0.0), position: 0:00:00.000000, caption: Caption(number: 0, start: 0:00:00.000000, end: 0:00:00.000000, text: ), captionOffset: 0:00:00.000000, buffered: [], isInitialized: false, isPlaying: false, isLooping: false, isBuffering: false, volume: 1.0, playbackSpeed: 1.0, errorDescription: null, isCompleted: false),)
I/flutter (27871): video url: https://res.cloudinary.com/dygfufopy/raw/upload/v1738775820/r57oejuigmyeiqiuswsu.mp4
D/EGL_emulation(27871): app_time_stats: avg=307.65ms min=48.09ms max=1060.28ms count=6
E/flutter (27871): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: PlatformException(channel-error, Unable to establish connection on channel., null, null)

l0oked at : https://stackoverflow.com/questions/75617154/flutter-video-player-init-has-not-been-implemented-error
https://stackoverflow.com/questions/74051227/flutter-video-player-not-working-when-load-video-from-file
*/
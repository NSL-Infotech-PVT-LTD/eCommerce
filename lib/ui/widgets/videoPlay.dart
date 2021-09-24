// import 'package:flutter/material.dart';
// import 'package:funfy/ui/videoTest/videoItem.dart';
// import 'package:video_player/video_player.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[100],
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Flutter Video Player Demo'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: <Widget>[
//           // VideoItems(
//           //   videoPlayerController: VideoPlayerController.asset(
//           //     'assets/video_6.mp4',
//           //   ),
//           //   looping: true,
//           //   autoplay: true,
//           // ),
//           // VideoItems(
//           //   videoPlayerController: VideoPlayerController.network(
//           //       'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'),
//           //   looping: false,
//           //   autoplay: true,
//           // ),
//           VideoItems(
//             videoPlayerController: VideoPlayerController.network(
//                 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
//             looping: false,
//             autoplay: true,
//           ),
//           // VideoItems(
//           //   videoPlayerController: VideoPlayerController.asset(
//           //     'assets/video_3.mp4',
//           //   ),
//           //   looping: false,
//           //   autoplay: false,
//           // ),
//           // VideoItems(
//           //   videoPlayerController: VideoPlayerController.asset(
//           //     'assets/video_2.mp4',
//           //   ),
//           //   autoplay: true,
//           // ),
//           // VideoItems(
//           //   videoPlayerController: VideoPlayerController.network(
//           //       "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"),
//           //   looping: true,
//           //   autoplay: false,
//           // ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class SamplePlayer extends StatefulWidget {
  final videoUrl;

  const SamplePlayer({Key? key, @required this.videoUrl}) : super(key: key);

  // SamplePlayer({Key? key}) : super(key: key);

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  FlickManager? flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
          "${widget.videoUrl ?? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'}"),
    );
  }

  @override
  void dispose() {
    flickManager!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      child: FlickVideoPlayer(flickManager: flickManager!),
    );
  }
}

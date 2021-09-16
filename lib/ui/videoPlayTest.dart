// import 'package:flutter/material.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:video_player/video_player.dart';

// class SamplePlayer extends StatefulWidget {
//   SamplePlayer({Key key}) : super(key: key);

//   @override
//   _SamplePlayerState createState() => _SamplePlayerState();
// }

// class _SamplePlayerState extends State<SamplePlayer> {
//   FlickManager flickManager;
//   @override
//   void initState() {
//     super.initState();
//     flickManager = FlickManager(
//       videoPlayerController: VideoPlayerController.network(
//           "https://app.funfyapp.com/uploads/samplevideos/1631693408.mp4"),
//     );
//   }

//   @override
//   void dispose() {
//     flickManager.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FlickVideoPlayer(flickManager: flickManager),
//     );
//   }
// }

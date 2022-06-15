import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String id;

  const VideoView({Key? key, required this.id}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  double opacity=1.0;
  @override
  void initState() {
    print(widget.id);
    _controller = VideoPlayerController.network(widget.id);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trailer'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        opacity=1.0;
                        Future.delayed(const Duration(seconds: 3)).then((value) {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              opacity=0.0;
                            } else {
                              opacity=1.0;
                            }
                          });
                        });
                      });

                    },
                      child: VideoPlayer(_controller)),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                          opacity=1.0;
                        } else {
                          _controller.play();
                          opacity=0.0;
                        }
                      });
                    },
                    child: Opacity(opacity: opacity,
                    child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow , color: Colors.white,size: 70.0,)),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'FileController.dart';

/*
 * 動画ウィジェット
 */
class DownloadMoviePlayerWidget extends StatefulWidget {

  @override
  _DownloadMoviePlayerWidgetState createState() => _DownloadMoviePlayerWidgetState();
}


/*
 * ステート
 */

class _DownloadMoviePlayerWidgetState extends State<DownloadMoviePlayerWidget> {

  // コントローラー
  VideoPlayerController _controller;

  @override
  void initState() {
    FileController.loadLocalMovie().then((value) => {

      // 動画プレーヤーの初期化
      _controller = VideoPlayerController.file(
        value
      )..initialize().then((_) {

      setState(() {});
      _controller.play();
      }).whenComplete(() => null)
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (_controller == null) return Container();

    if (_controller.value.initialized) {

      /*
       * 動画
       */
      return Container(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      );
    } else {

      /*
       * インジケータを表示
       */
      return Container(
        height: 150.0,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
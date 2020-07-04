
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

/*
 * 動画ウィジェット
 */
class MoviePlayerWidget extends StatefulWidget {

  PlayType playType;
  String movieURL; // 動画URL
  MoviePlayerWidget(this.playType, this.movieURL) : super();

  @override
  _MoviePlayerWidgetState createState() => _MoviePlayerWidgetState();
}


/*
 * ステート
 */

class _MoviePlayerWidgetState extends State<MoviePlayerWidget> {

  // コントローラー
  VideoPlayerController _controller;

  @override
  void initState() {
    final fileName = widget.movieURL.split("/").removeLast();
    // 動画プレーヤーの初期化
    if(widget.playType == PlayType.Web){
      _controller = VideoPlayerController.network(
          widget.movieURL
      )..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    }
    else if(widget.playType == PlayType.Local) {
      getApplicationDocumentsDirectory().then((directory) => {
        // 動画プレーヤーの初期化
        _controller = VideoPlayerController.file(
          File(directory.path + Platform.pathSeparator + 'TestApp'
              + Platform.pathSeparator + fileName)
        )..initialize().then((_) {
          setState(() {});
          _controller.play();
        }).whenComplete(() => null)
      });
    }

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

enum PlayType {
  Web, Local
}
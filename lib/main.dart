import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'FileDownload.dart';
import 'MoviePlayerWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      // homeかinitialRoute & routes どちらかのみ
      home:MainPage()
    );
  }
}
/// メインページ
class MainPage extends StatelessWidget {
  // テキストフィールドを管理するコントローラを作成
  // 入力された内容をこのコントローラを使用して取り出します。
  var myController = TextEditingController(text: "https://www.home-movie.biz/mov/hts-samp005.mp4");
  //var myController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('メインページ')),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(50, 20, 50, 10),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              '''
              Flutterを練習するためのテストアプリ
              Hello World！
              ''',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            TextField(
                controller: myController
            ),

            // 動画再生画面
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){ // push(context, Route)で遷移先を指定
                  return MoviePlayPage(myController.text);
                }));
              },
              child: Text('Web動画再生ページ'),
            ),

            // 動画ダウンロード
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){ // push(context, Route)で遷移先を指定
                  return MovieDownloadPage(myController.text);
                }));
              },
              child: Text('動画ダウンロードページ'),
            ),

            // ダウンロード済み動画再生画面
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){ // push(context, Route)で遷移先を指定
                  return DownloadMoviePlayPage(myController.text);
                }));
              },
              child: Text('ダウンロード動画再生ページ'),
            ),
          ],
        )
      ),
    );
  }
}

/// 動画再生画面
class MoviePlayPage extends StatelessWidget {
  var movieUrl;
  MoviePlayPage(this.movieUrl);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Web動画再生"),
      ),
      body: Center(
          child: Container(
            child: MoviePlayerWidget(
              PlayType.Web, movieUrl
            ),
          )
      ),
    );
  }
}

/// 動画ダウンロード画面
class MovieDownloadPage extends StatelessWidget {
  final movieUrl;
  MovieDownloadPage(this.movieUrl);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ダウンロード"),
      ),
      body: Center(
          child: Container(
            child: DownloadMoviePage(movieUrl),
          )
      ),
    );
  }
}

/// 動画再生画面
class DownloadMoviePlayPage extends StatelessWidget {
  final movieUrl;
  DownloadMoviePlayPage(this.movieUrl);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("動画再生"),
      ),
      body: Center(
        child: Container(
          child: MoviePlayerWidget(
            PlayType.Local, movieUrl
          ),
        )
      ),
    );
  }
}

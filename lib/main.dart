import 'package:flutter/material.dart';
import 'FileDownload.dart';
import 'MoviePlayerWidget.dart';
import 'DownloadMoviePlayerWidget.dart';

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
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      //home: FirstPage(),  // homeかinitialRoute & routes どちらかのみ
      home:FirstPage()
    );
  }
}

class FirstPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Container(
        alignment: Alignment.center,

        child: Column(
          children: <Widget>[
            // 動画再生画面
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){ // push(context, Route)で遷移先を指定
                  return MoviePlayPage("https://www.home-movie.biz/mov/hts-samp005.mp4");
                }));
              },
              child: Text('Web動画再生ページ'),
            ),

            // 動画ダウンロード
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){ // push(context, Route)で遷移先を指定
                  return MovieDownloadPage();
                }));
              },
              child: Text('動画ダウンロードページ'),
            ),

            // ダウンロード済み動画再生画面
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){ // push(context, Route)で遷移先を指定
                  return DownloadMoviePlayPage();
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
        title: Text("動画再生"),
      ),
      body: Center(
          child: Container(
            child: MoviePlayerWidget(
              movieUrl,
            ),
          )
      ),
    );
  }
}

/// 動画ダウンロード画面
class MovieDownloadPage extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ダウンロード"),
      ),
      body: Center(
          child: Container(
            child: DownloadMoviePage(),
          )
      ),
    );
  }
}

/// 動画再生画面
class DownloadMoviePlayPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("動画再生"),
      ),
      body: Center(
          child: Container(
            child: DownloadMoviePlayerWidget(),
          )
      ),
    );
  }
}

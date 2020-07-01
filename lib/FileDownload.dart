import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class DownloadMoviePage extends StatefulWidget {
  DownloadMoviePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DownloadMoviePageState createState() => _DownloadMoviePageState();
}

class _DownloadMoviePageState extends State<DownloadMoviePage> {
  String _localPath;
  String _contents;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      downloadFile('https://www.home-movie.biz/mov/hts-samp009.mp4',//download url
          'hts-samp009.mp4',//ファイル名
          _localPath);//保存先ディレクトリ
      _counter++;
      debugPrint(_localPath);
    });
  }

  @override
  void initState() {
    super.initState();
    _prepare();
  }

  Future<String> _findLocalPath(BuildContext context) async {
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<Null> _prepare() async {
    await FlutterDownloader.initialize();
    final directory = await getApplicationDocumentsDirectory();
    _localPath = directory.path;
    // ignore: prefer_interpolation_to_compose_strings

//    (await _findLocalPath(context)) + Platform.pathSeparator + 'Download';
//
//    final savedDir = Directory(_localPath);
//    bool hasExisted = await savedDir.exists();
//    if (!hasExisted) {
//      await savedDir.create();
//    }
  }

  //Platform.pathSeparatorは Macでいうところの/のPlatform間の違いをなくすもの
  //Download は例
  void downloadFile(String fileUrl, String fileName, String saveDir) async {
    await FlutterDownloader.enqueue(
      url: fileUrl,
      fileName: fileName,
      savedDir: saveDir,
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification:
      true, // click on notification to open downloaded file (for Android)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Download',
        child: Icon(Icons.file_download),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
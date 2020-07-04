import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class DownloadMoviePage extends StatefulWidget {
  DownloadMoviePage(this.downloadUrl, {Key key}) : super(key: key);
  final String downloadUrl;

  @override
  _DownloadMoviePageState createState() => _DownloadMoviePageState();
}

class _DownloadMoviePageState extends State<DownloadMoviePage> {
  String _localPath;

  void fileDownload() {
    final fileName = widget.downloadUrl.split("/").removeLast();
    setState(() {
      downloadFile(widget.downloadUrl,//download url
          fileName,//ファイル名
          _localPath);//保存先ディレクトリ
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
    _localPath = directory.path + Platform.pathSeparator + 'TestApp';
    // ignore: prefer_interpolation_to_compose_strings

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      await savedDir.create();
    }
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fileDownload,
        tooltip: 'Download',
        child: Icon(Icons.file_download),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
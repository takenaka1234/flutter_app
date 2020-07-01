
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileController {
  // ドキュメントのパスを取得
  static Future get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future saveLocalMovie(File movie) async {
    final path = await localPath;
    final moviePath = '$path/movie.mp4';
    File movieFile = File(moviePath);
    // カメラで撮影した画像は撮影時用の一時的フォルダパスに保存されるため、
    // その画像をドキュメントへ保存し直す。
    var savedFile = await movieFile.writeAsBytes(await movie.readAsBytes());
    // もしくは
    // var savedFile = await image.copy(imagePath);
    // でもOK

    return savedFile;
  }

  static Future loadLocalMovie() async {
    final path = await localPath;
    final moviePath = '$path/hts-samp009.mp4';
    return File(moviePath);
  }
}
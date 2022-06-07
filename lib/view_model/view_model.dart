import 'dart:io';

import 'package:file_pick_persistence_sample/db/database.dart';
import 'package:file_pick_persistence_sample/model/file_pick_manager.dart';
import 'package:file_pick_persistence_sample/model/sound_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

enum PickFileType {
  IMAGE,
  SOUND,
}

class ViewModel extends ChangeNotifier {
  final filePickManager = FilePickManager();
  final db = MyDatabase();
  final soundManager = SoundManager();

  File? get imageFile => filePickManager.imageFile;
  File? get soundFile => filePickManager.soundFile;
  List<Post> posts = [];

  Future<void> pickFile(PickFileType fileType) async {
    await filePickManager.pickFile(fileType);
    notifyListeners();
  }

  Future<void> getAllPosts() async {
    posts = await db.allPosts;

    if (Platform.isIOS && posts.isNotEmpty) {
      posts = filePickManager.convertPaths(posts);
    }
    notifyListeners();
  }

  Future<void> createMessage(String message) async {
    /*
    * iOSの場合は、一旦アプリを閉じて再度開くとファイルにアクセスできないエラーになる（Androidはイケるのに）
    * （Cannot open file, path ='/private/var/mobile/Containers/Data/Application/・・ (OS Error: No such file or directory, errno = 2)
    *  => DB保存時にPickしたファイルを内部ストレージに保存して内部ストレージのpathをDBに保存するようにする必要あり？
    *   https://docs.flutter.dev/cookbook/persistence/reading-writing-files#3-write-data-to-the-file
    *   https://github.com/ryanheise/just_audio/issues/411#issuecomment-851605582
    *
    *   iOSの場合はPickされたファイルデータはアプリ内のキャッシュ（tmpフォルダ）に格納され、そのpathが取得される
    *   （Androidのように端末内の実ファイルの場所を取得してくれるわけではない）
    *   => アプリ内Containerの中のAppData/tmpにいる => アプリを閉じても消えてないのになぜかアクセスできない？？
    *   => いずれにしてもiOSの場合は一旦ローカルに保存されているので、
    *       １．そのファイルデータをアプリからアクセスできるパスに書き込み直して
    *       ２．キャッシュを削除してやれば、内部ストレージの無駄遣いをせずに済みそう
    *   「/private/var/mobile/Containers/Data/Application/6A5E7A10-60C3-449B-AC26-7CE3526486C6/tmp/IMG_0885.jpeg'」
    *   https://github.com/ryanheise/just_audio/issues/411#issuecomment-851605582
    * */

    final id = Uuid().v1();

    //iOSの場合は、一旦ファイルをアプリ内（ローカルに保存する必要あり）
    //https://github.com/ryanheise/just_audio/issues/411#issuecomment-851605582
    if (Platform.isIOS) {
      await filePickManager.writeFilesToInternalStorage();
    }

    //DBに保存
    await db.createMessage(
      Post(
        id: id,
        imagePath: (imageFile != null)
            ? Platform.isAndroid
                ? imageFile!.path
                : path.basename(imageFile!.path)
            : "",
        soundPath: (soundFile != null)
            ? (Platform.isAndroid)
                ? soundFile!.path
                : path.basename(soundFile!.path)
            : "",
        message: message,
      ),
    );

    filePickManager.clear();
    getAllPosts();
  }

  void playSound(String soundPath) {
    soundManager.playSound(soundPath);
  }

  @override
  void dispose() {
    soundManager.dispose();
    super.dispose();
  }
}

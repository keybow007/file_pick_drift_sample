import 'dart:io';

import 'package:file_pick_persistence_sample/db/database.dart';
import 'package:file_pick_persistence_sample/main.dart';
import 'package:file_pick_persistence_sample/view_model/view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FilePickManager {
  File? imageFile;
  File? soundFile;

  Future<String?> pickFile(PickFileType fileType) async {
    final filePickResult = await FilePicker.platform.pickFiles(
      type: (fileType == PickFileType.IMAGE) ? FileType.image : FileType.audio,
    );

    if (filePickResult != null) {
      final pickedFile = filePickResult.files.single;
      if (fileType == PickFileType.IMAGE) {
        imageFile = (pickedFile.path != null) ? File(pickedFile.path!) : null;
      } else {
        soundFile = (pickedFile.path != null) ? File(pickedFile.path!) : null;
      }
    }
    return null;
  }

  void clear() {
    imageFile = null;
    soundFile = null;
  }

  Future<void> writeFilesToInternalStorage() async {
    if (imageFile != null) {
      imageFile = await writeAndGetLocalPath(imageFile!, PickFileType.IMAGE);
    }

    if (soundFile != null) {
      soundFile = await writeAndGetLocalPath(soundFile!, PickFileType.SOUND);
    }
  }

  Future<File> writeAndGetLocalPath(File originalFile, PickFileType fileType) async {
    /*
    * iOSの場合は、一旦アプリを閉じて再度開くと画像ファイルにアクセスできないエラーになる
    * （Cannot open file, path ='/private/var/mobile/Containers/Data/Application/・・ (OS Error: No such file or directory, errno = 2)
    *  => DB保存時にPickしたファイルを内部ストレージに保存して内部ストレージのpathをDBに保存するようにする必要あり
    *   https://docs.flutter.dev/cookbook/persistence/reading-writing-files#3-write-data-to-the-file
    * */

    //https://docs.flutter.dev/cookbook/persistence/reading-writing-files#4-read-data-from-the-file
    final byteData = await originalFile.readAsBytes();

    //File名の取得（pathパッケージ）
    //https://stackoverflow.com/a/50439988/13944817
    final fineName = path.basename(originalFile.path);

    //final filePath = "$appDirectoryPath/$fineName";
    final filePath = path.join(appDirectoryPath!, fineName);
    final localFile = File(filePath);

    //https://docs.flutter.dev/cookbook/persistence/reading-writing-files#3-write-data-to-the-file
    await localFile.writeAsBytes(byteData);

    //元のファイル（tmpフォルダにあるもの）を削除
    await originalFile.delete();

    return localFile;
  }

  List<Post> convertPaths(List<Post> posts) {
    var convertedPosts = <Post>[];
    posts.forEach((post) {
      final convertedPost = post.copyWith(
        imagePath: "$appDirectoryPath/${post.imagePath}",
        soundPath: "$appDirectoryPath/${post.soundPath}",
      );
      convertedPosts.add(convertedPost);
    });
    return convertedPosts;
  }
}

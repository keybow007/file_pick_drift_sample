import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Posts extends Table {
  TextColumn get id => text()();
  TextColumn get message => text()();
  TextColumn get imageFileName => text()();
  TextColumn get soundFileName => text()();
}

@DriftDatabase(tables: [Posts])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> createMessage(Post post) {
    return into(posts).insert(post);
  }

  Future<List<Post>> get allPosts => select(posts).get();

}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}


// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PostsTable extends Posts with TableInfo<$PostsTable, Post> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _soundPathMeta =
      const VerificationMeta('soundPath');
  @override
  late final GeneratedColumn<String> soundPath = GeneratedColumn<String>(
      'sound_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, message, imagePath, soundPath];
  @override
  String get aliasedName => _alias ?? 'posts';
  @override
  String get actualTableName => 'posts';
  @override
  VerificationContext validateIntegrity(Insertable<Post> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('sound_path')) {
      context.handle(_soundPathMeta,
          soundPath.isAcceptableOrUnknown(data['sound_path']!, _soundPathMeta));
    } else if (isInserting) {
      context.missing(_soundPathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Post map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Post(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      soundPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sound_path'])!,
    );
  }

  @override
  $PostsTable createAlias(String alias) {
    return $PostsTable(attachedDatabase, alias);
  }
}

class Post extends DataClass implements Insertable<Post> {
  final String id;
  final String message;
  final String imagePath;
  final String soundPath;
  const Post(
      {required this.id,
      required this.message,
      required this.imagePath,
      required this.soundPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['message'] = Variable<String>(message);
    map['image_path'] = Variable<String>(imagePath);
    map['sound_path'] = Variable<String>(soundPath);
    return map;
  }

  PostsCompanion toCompanion(bool nullToAbsent) {
    return PostsCompanion(
      id: Value(id),
      message: Value(message),
      imagePath: Value(imagePath),
      soundPath: Value(soundPath),
    );
  }

  factory Post.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Post(
      id: serializer.fromJson<String>(json['id']),
      message: serializer.fromJson<String>(json['message']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      soundPath: serializer.fromJson<String>(json['soundPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'message': serializer.toJson<String>(message),
      'imagePath': serializer.toJson<String>(imagePath),
      'soundPath': serializer.toJson<String>(soundPath),
    };
  }

  Post copyWith(
          {String? id,
          String? message,
          String? imagePath,
          String? soundPath}) =>
      Post(
        id: id ?? this.id,
        message: message ?? this.message,
        imagePath: imagePath ?? this.imagePath,
        soundPath: soundPath ?? this.soundPath,
      );
  @override
  String toString() {
    return (StringBuffer('Post(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('imagePath: $imagePath, ')
          ..write('soundPath: $soundPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, message, imagePath, soundPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Post &&
          other.id == this.id &&
          other.message == this.message &&
          other.imagePath == this.imagePath &&
          other.soundPath == this.soundPath);
}

class PostsCompanion extends UpdateCompanion<Post> {
  final Value<String> id;
  final Value<String> message;
  final Value<String> imagePath;
  final Value<String> soundPath;
  final Value<int> rowid;
  const PostsCompanion({
    this.id = const Value.absent(),
    this.message = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.soundPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PostsCompanion.insert({
    required String id,
    required String message,
    required String imagePath,
    required String soundPath,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        message = Value(message),
        imagePath = Value(imagePath),
        soundPath = Value(soundPath);
  static Insertable<Post> custom({
    Expression<String>? id,
    Expression<String>? message,
    Expression<String>? imagePath,
    Expression<String>? soundPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (message != null) 'message': message,
      if (imagePath != null) 'image_path': imagePath,
      if (soundPath != null) 'sound_path': soundPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PostsCompanion copyWith(
      {Value<String>? id,
      Value<String>? message,
      Value<String>? imagePath,
      Value<String>? soundPath,
      Value<int>? rowid}) {
    return PostsCompanion(
      id: id ?? this.id,
      message: message ?? this.message,
      imagePath: imagePath ?? this.imagePath,
      soundPath: soundPath ?? this.soundPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (soundPath.present) {
      map['sound_path'] = Variable<String>(soundPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostsCompanion(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('imagePath: $imagePath, ')
          ..write('soundPath: $soundPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $PostsTable posts = $PostsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [posts];
}

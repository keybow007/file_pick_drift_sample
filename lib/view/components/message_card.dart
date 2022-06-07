import 'dart:io';

import 'package:file_pick_persistence_sample/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db/database.dart';

class MessageCard extends StatelessWidget {
  final Post post;

  const MessageCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: (post.imagePath != "") ? Image.file(File(post.imagePath)) : Image.network(
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
        ),
        subtitle: Text(post.message),
        trailing: IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () => _playSound(context, post.soundPath),
        ),
      ),
    );
  }

  _playSound(BuildContext context, String soundPath) {
    final vm = context.read<ViewModel>();
    vm.playSound(soundPath);
  }
}

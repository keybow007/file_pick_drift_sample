import 'dart:io';

import 'package:file_pick_persistence_sample/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateCardDialog extends StatefulWidget {
  const CreateCardDialog({Key? key}) : super(key: key);

  @override
  State<CreateCardDialog> createState() => _CreateCardDialogState();
}

class _CreateCardDialogState extends State<CreateCardDialog> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("メッセージの入力"),
        actions: [
          IconButton(
            onPressed: () async {
              await _createMessage(context, messageController.text);
              Navigator.pop(context);
            },
            icon: Icon(Icons.done),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ViewModel>(
          builder: (context, vm, child) {
            final imageFile = vm.imageFile;
            final soundFile = vm.soundFile;
            return Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _pickFile(context, PickFileType.IMAGE),
                    child: (imageFile != null)
                        ? Image.file(imageFile)
                        : Image.network(
                            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                          ),
                  ),
                ),
                Container(
                  color: Colors.blueAccent.withOpacity(0.5),
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () => _pickFile(context, PickFileType.SOUND),
                      child: Center(
                        child: Text((soundFile != null) ? soundFile.path : "クリックして音声ファイルを選択"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: messageController,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _pickFile(BuildContext context, PickFileType fileType) {
    final vm = context.read<ViewModel>();
    vm.pickFile(fileType);
  }

  Future<void> _createMessage(BuildContext context, String message) async {
    final vm = context.read<ViewModel>();
    await vm.createMessage(message);
  }
}

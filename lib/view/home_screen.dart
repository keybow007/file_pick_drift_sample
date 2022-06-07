import 'package:file_pick_persistence_sample/view/components/create_card_dialog.dart';
import 'package:file_pick_persistence_sample/view/components/message_card.dart';
import 'package:file_pick_persistence_sample/view_model/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    Future((){
      final vm = context.read<ViewModel>();
      vm.getAllPosts();
    });

    return Scaffold(
      body: Consumer<ViewModel>(
        builder: (context, vm, child) {
          final posts = vm.posts;
          return (posts.isEmpty) ? Container() : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, int index) {
                final post = posts[index];
                return MessageCard(
                  post: post,
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createCard(context, screenHeight),
      ),
    );
  }

  _createCard(BuildContext context, double screenHeight) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          child: SizedBox(
            height: screenHeight / 2,
            child: CreateCardDialog(),
          ),
        );
      },
    );
  }
}

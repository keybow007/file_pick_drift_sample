import 'dart:io';

import 'package:file_pick_persistence_sample/view/home_screen.dart';
import 'package:file_pick_persistence_sample/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

late Directory appDirectory;
late String? appDirectoryPath;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  appDirectory = await getApplicationDocumentsDirectory();
  appDirectoryPath = appDirectory.path;

  runApp(
      ChangeNotifierProvider(
        create: (_) => ViewModel(),
        child: MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

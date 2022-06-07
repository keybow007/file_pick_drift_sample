import 'package:just_audio/just_audio.dart';

class SoundManager {
  final audioPlayer = AudioPlayer();

  void playSound(String soundPath) async {
    await audioPlayer.setFilePath(soundPath);
    audioPlayer.play();
  }

  void dispose() {
    audioPlayer.dispose();
  }

}
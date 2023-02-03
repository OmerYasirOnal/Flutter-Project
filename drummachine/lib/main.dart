import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DrumMachine());
}

class DrumMachine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: DrumPage(),
      ),
    );
  }
}

class DrumPage extends StatelessWidget {
  final assetsAudioPlayer = AssetsAudioPlayer();

  void playSound(String ses) {
    assetsAudioPlayer.open(
      Audio('assets/audios/$ses.wav'),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: buildMaterialPad('bongo', Colors.red),
                  ),
                  Expanded(
                    child: buildMaterialPad('bip', Colors.yellow),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: buildMaterialPad('clap1', Colors.blue)),
                  Expanded(child: buildMaterialPad('how', Colors.redAccent)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: buildMaterialPad('clap3', Colors.greenAccent)),
                  Expanded(child: buildMaterialPad('ridebel', Colors.green)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: buildMaterialPad('woo', Colors.yellowAccent)),
                  Expanded(
                      child: buildMaterialPad('oobah', Colors.purpleAccent)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: buildMaterialPad('clap2', Colors.brown)),
                  Expanded(child: buildMaterialPad('crash', Colors.cyanAccent)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  MaterialButton buildMaterialPad(String ses, Color renk) {
    return MaterialButton(
      padding: EdgeInsets.all(8),
      onPressed: () {
        playSound(ses);
      },
      child: Container(
        color: renk,
      ),
    );
  }
}

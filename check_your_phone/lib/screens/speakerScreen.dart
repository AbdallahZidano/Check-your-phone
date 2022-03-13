import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:check_your_phone/helper/navigatorHelper.dart';
import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeakerScreen extends StatefulWidget {
  @override
  _SpeakerScreenState createState() => _SpeakerScreenState();
}

class _SpeakerScreenState extends State<SpeakerScreen> {
  final player = new AudioCache(fixedPlayer: AudioPlayer());

  setFullScreen() async {
    await FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
  }

  exitFullScreen() async {
    await FullScreen.exitFullScreen();
  }

  playSound() {
    const alarmAudioPath = "sounds/sssss.m4a";
    player.play(alarmAudioPath);
  }

  @override
  void initState() {
    super.initState();
    setFullScreen();
    playSound();
  }

  @override
  void dispose() {
    super.dispose();
    player.fixedPlayer.stop();
    exitFullScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          back(context);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "The speaker is working now",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

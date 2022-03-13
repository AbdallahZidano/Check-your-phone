import 'package:check_your_phone/helper/navigatorHelper.dart';
import 'package:earpiece_audio/earpiece_audio.dart';
import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiverScreen extends StatefulWidget {
  @override
  _ReceiverScreenState createState() => _ReceiverScreenState();
}

class _ReceiverScreenState extends State<ReceiverScreen> {
  String text = "The speaker is working now";
  EarpieceAudio _earpiece = EarpieceAudio();
  Future<void> initPlatformState() async {
    final responsePath = await _earpiece.play("sounds/sssss.m4a");
  }

  setFullScreen() async {
    await FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
  }

  exitFullScreen() async {
    await FullScreen.exitFullScreen();
  }

  @override
  void initState() {
    super.initState();
    setFullScreen();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    exitFullScreen();
    _earpiece.stop();
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
                text,
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

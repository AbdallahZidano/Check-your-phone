import 'package:check_your_phone/helper/navigatorHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fullscreen/fullscreen.dart';

class VibrationScreen extends StatefulWidget {
  @override
  _VibrationScreenState createState() => _VibrationScreenState();
}

class _VibrationScreenState extends State<VibrationScreen> {
  setFullScreen() async {
    await FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
  }

  exitFullScreen() async {
    await FullScreen.exitFullScreen();
  }

  @override
  void dispose() {
    super.dispose();
    exitFullScreen();
  }

  startVibrate() async {
    Vibrate.vibrateWithPauses([
      const Duration(milliseconds: 100),
      const Duration(milliseconds: 100),
      const Duration(milliseconds: 100),
      const Duration(milliseconds: 100),
      const Duration(milliseconds: 100),
      const Duration(milliseconds: 100),
      const Duration(milliseconds: 100),
      const Duration(milliseconds: 100),
    ]);
    print('The device is now vibrating');
  }

  @override
  void initState() {
    super.initState();
    setFullScreen();
    startVibrate();
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
                'The device is now vibrating',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

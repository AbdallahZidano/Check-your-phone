import 'package:check_your_phone/helper/colorHelper.dart';
import 'package:check_your_phone/helper/navigatorHelper.dart';
import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';

class ScreenScreen extends StatefulWidget {
  @override
  _ScreenScreenState createState() => _ScreenScreenState();
}

class _ScreenScreenState extends State<ScreenScreen> {
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
  }

  @override
  void dispose() {
    super.dispose();
    exitFullScreen();
  }

  List<Color> colorList = [
    ColorsHelper.red,
    ColorsHelper.green,
    ColorsHelper.blue,
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          if (index < 2) {
            setState(() {
              index++;
            });
          } else {
            back(context);
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: colorList[index],
        ),
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/homeCard.dart';
import '../helper/colorHelper.dart';
import 'cameraScreen.dart';
import 'frontCam.dart';
import 'touchScreen.dart';
import 'screenScreen.dart';
import '../screens/receiverScreen.dart';
import '../screens/sensorScreen.dart';
import '../screens/speakerScreen.dart';
import '../screens/vibrationScreen.dart';

class HomeScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  const HomeScreen({this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.lightGrey,
      appBar: AppBar(
        backgroundColor: ColorsHelper.darkGrey,
        title: Text('Check Your Phone'),
        centerTitle: true,
      ),
      body: GridView.count(
        primary: false,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
        crossAxisSpacing: 40,
        mainAxisSpacing: 25,
        crossAxisCount: 2,
        children: <Widget>[
          buildHomeCard(context, 'call.png', 'Receiver', ReceiverScreen()),
          buildHomeCard(
              context, 'camera.png', 'Camera', CameraScreen(cameras: cameras)),
          buildHomeCard(context, 'frontCam.png', 'Front Camera',
              FrontCamScreen(cameras: cameras)),
          buildHomeCard(context, 'screen.png', 'Screen', ScreenScreen()),
          buildHomeCard(context, 'sensor.png', 'Sensor', SensorScreen()),
          buildHomeCard(context, 'speaker.png', 'Speaker', SpeakerScreen()),
          buildHomeCard(
              context, 'vipration.png', 'Vibration', VibrationScreen()),
          buildHomeCard(context, 'touch.png', 'Touch', TouchScreen()),
        ],
      ),
    );
  }
}

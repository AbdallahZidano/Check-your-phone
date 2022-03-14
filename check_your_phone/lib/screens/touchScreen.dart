import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';

class TouchScreen extends StatefulWidget {
  @override
  _TouchScreenState createState() => _TouchScreenState();
}

class _TouchScreenState extends State<TouchScreen> {
  Color selectedColor = Colors.black;
  Color pickerColor = Colors.black;
  double strokeWidth = 3.0;
  double opacity = 1.0;
  bool showBottomList = false;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  SelectedMode selectedMode = SelectedMode.StrokeWidth;
  List<DrawingPoints> points = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/touchScreen.png',
            fit: BoxFit.fill,
          ),
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                points.add(DrawingPoints(
                    points: renderBox.globalToLocal(details.globalPosition),
                    paint: Paint()
                      ..strokeCap = strokeCap
                      ..isAntiAlias = true
                      ..color = selectedColor.withOpacity(opacity)
                      ..strokeWidth = strokeWidth));
              });
            },
            onPanStart: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                points.add(DrawingPoints(
                    points: renderBox.globalToLocal(details.globalPosition),
                    paint: Paint()
                      ..strokeCap = strokeCap
                      ..isAntiAlias = true
                      ..color = selectedColor.withOpacity(opacity)
                      ..strokeWidth = strokeWidth));
              });
            },
            onPanEnd: (details) {
              setState(() {
                points.add(null);
              });
            },
            child: CustomPaint(
              size: Size.infinite,
              painter: DrawingPainter(
                pointsList: points,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: ClipOval(
        child: Container(
          height: 35,
          width: 35,
          color: color,
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  List<DrawingPoints> pointsList = [];
  List<Offset> offsetPoints = [];

  DrawingPainter({this.pointsList});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint paint;
  Offset points;

  DrawingPoints({this.paint, this.points});
}

enum SelectedMode { StrokeWidth, Opacity, Color }

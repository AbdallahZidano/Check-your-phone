import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  CameraScreen({
    this.cameras,
  });

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  setFullScreen() async {
    await FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
  }

  exitFullScreen() async {
    await FullScreen.exitFullScreen();
  }

  @override
  void initState() {
    super.initState();
    initializeCamera(selectedCamera); //Initially selectedCamera = 0
    setFullScreen();
  }

  CameraController _controller; //To control the camera
  Future<void>
      _initializeControllerFuture; //Future to wait until camera initializes
  int selectedCamera = 0;

  initializeCamera(int cameraIndex) async {
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.cameras[cameraIndex],
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    exitFullScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    Center(
                      child: CameraPreview(_controller),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}

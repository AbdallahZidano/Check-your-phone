import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';

class FrontCamScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  FrontCamScreen({
    this.cameras,
  });

  @override
  _FrontCamScreenState createState() => _FrontCamScreenState();
}

class _FrontCamScreenState extends State<FrontCamScreen> {
  CameraController _controller; //To control the camera
  Future<void>
      _initializeControllerFuture; //Future to wait until camera initializes
  int selectedCamera = 1;

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

  @override
  void dispose() {
    super.dispose();
    exitFullScreen();
  }

  @override
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return Center(child: CameraPreview(_controller));
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}

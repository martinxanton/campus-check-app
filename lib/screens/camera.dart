import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:campus_check_app/main.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late final CameraController controller;

  int _currentSelection = 1;

  void initializeCamera() async {
    final CameraController cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );
    controller = cameraController;

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    initializeCamera();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      body: controller.value.isInitialized
          ? SafeArea(
              child: Stack(
              children: <Widget>[
                SizedBox(
                    height: size.height,
                    child: Transform.scale(
                        scale: 1 / (controller.value.aspectRatio * deviceRatio),
                        child: CameraPreview(controller))),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 250,
                    height: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: CustomSlidingSegmentedControl<int>(
                      initialValue: 1,
                      children: {
                        1: Text('Entrada',
                            style: TextStyle(
                                color: _currentSelection == 1
                                    ? Colors.black
                                    : Colors.white)),
                        2: Text('Salida',
                            style: TextStyle(
                                color: _currentSelection == 2
                                    ? Colors.black
                                    : Colors.white)),
                      },
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      thumbDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInToLinear,
                      onValueChanged: (v) {
                        setState(() {
                          _currentSelection = v;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonFlash(controller: controller),
                        ButtonZoom(controller: controller),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 40, // ajusta el tamaño según tus necesidades
                            height:
                                40, // ajusta el tamaño según tus necesidades
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ))
          : Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}

class ButtonZoom extends StatefulWidget {
  const ButtonZoom({
    super.key,
    required this.controller,
  });

  final CameraController controller;

  @override
  State<ButtonZoom> createState() => _ButtonZoomState();
}

class _ButtonZoomState extends State<ButtonZoom> {
  bool isZoomed = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.controller.setZoomLevel(isZoomed ? 1.0 : 2.0);
          isZoomed = !isZoomed;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isZoomed ? Colors.white : Colors.black.withOpacity(0.6),
        ),
        child: Icon(
          isZoomed ? Icons.zoom_out : Icons.zoom_in,
          color: isZoomed ? Colors.black : Colors.white,
          size: 25,
        ),
      ),
    );
  }
}

class ButtonFlash extends StatefulWidget {
  const ButtonFlash({
    super.key,
    required this.controller,
  });

  final CameraController controller;

  @override
  State<ButtonFlash> createState() => _ButtonFlashState();
}

class _ButtonFlashState extends State<ButtonFlash> {
  bool isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.controller
              .setFlashMode(isFlashOn ? FlashMode.off : FlashMode.torch);
          isFlashOn = !isFlashOn;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isFlashOn ? Colors.white : Colors.black.withOpacity(0.6),
        ),
        child: Icon(
          isFlashOn ? Icons.flash_on : Icons.flash_off,
          color: isFlashOn ? Colors.black : Colors.white,
          size: 25,
        ),
      ),
    );
  }
}

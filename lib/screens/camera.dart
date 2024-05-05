import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:campus_check_app/main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // Inside _CameraScreenState class

  late final CameraController controller;

  int _currentSelection = 0;

  final Map<int, Widget> _children = {
    0: const Text('      Entrada      '),
    1: const Text('      Salida      ')
  };

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

/*
  // Takes picture with the selected device camera, and
// returns the image path
  Future<String?> takePicture() async {
    if (!controller.value.isInitialized) {
      print("Controller is not initialized");
      return null;
    }

    String? imagePath;

    if (controller.value.isTakingPicture) {
      print("Processing is in progress...");
      return null;
    }

    try {
      // Turning off the camera flash
      controller.setFlashMode(FlashMode.off);
      // Returns the image in cross-platform file abstraction
      final XFile file = await controller.takePicture();
      // Retrieving the path
      imagePath = file.path;
    } on CameraException catch (e) {
      print("Camera Exception: $e");
      return null;
    }

    return imagePath;
  }
*/

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
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: MaterialSegmentedControl(
                      children: _children,
                      selectionIndex: _currentSelection,
                      borderColor: Colors.black.withOpacity(0.6),
                      selectedColor: Colors.white,
                      unselectedColor: Colors.black.withOpacity(0.6),
                      selectedTextStyle: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      unselectedTextStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      borderWidth: 0.7,
                      borderRadius: 32.0,
                      onSegmentTapped: (index) {
                        setState(() {
                          _currentSelection = index;
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
        width: 40, // ajusta el tamaño según tus necesidades
        height: 40, // ajusta el tamaño según tus necesidades
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




/*
class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  int selectedValue = 1;

  void _onValueSelected(Set<int> value) {
    setState(() {
      selectedValue = value.first;
    });
  }

  List<ButtonSegment<int>> _buttonSegments() {
    return const [
      ButtonSegment(
          value: 1, label: Text('Entrada'), icon: Icon(Icons.login_rounded)),
      ButtonSegment(
          value: 2, label: Text('Salida'), icon: Icon(Icons.logout_rounded)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SegmentedButton(
          segments: _buttonSegments(),
          selected: {selectedValue},
          onSelectionChanged: _onValueSelected,
        )
      ],
    );
  }
}

*/
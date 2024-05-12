import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:campus_check_app/view/components/camera.dart';
import 'package:campus_check_app/view/painters/face_mesh_detector_painter.dart';
import 'package:campus_check_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceMeshDetectorView extends StatefulWidget {
  const FaceMeshDetectorView({super.key});

  @override
  State<FaceMeshDetectorView> createState() => _FaceMeshDetectorViewState();
}

class _FaceMeshDetectorViewState extends State<FaceMeshDetectorView> {
  final FaceMeshDetector _meshDetector =
      FaceMeshDetector(option: FaceMeshDetectorOptions.faceMesh);
  final faceDetector =
      FaceDetector(options: FaceDetectorOptions(enableTracking: true));
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  // ignore: unused_field
  String? _text;
  final _cameraLensDirection = CameraLensDirection.back;
  @override
  void dispose() {
    _canProcess = false;
    _meshDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Scaffold(
        appBar: AppBar(title: const Text('Under construction')),
        body: const Center(
            child: Text(
          'Not implemented yet for iOS :(\nTry Android',
          textAlign: TextAlign.center,
        )),
      );
    }
    return Stack(
      children: [
        CameraView(customPaint: _customPaint, onImage: _processImage),
      ],
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final meshes = await _meshDetector.processImage(inputImage);
    final List<Face> faces = await faceDetector.processImage(inputImage);

    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceMeshDetectorPainter(
        meshes,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
      // ignore: avoid_print
      print('Face meshes found: ${meshes.length}');
      for (Face face in faces) {
        final Rect boundingBox = face.boundingBox;

        final double? rotX =
            face.headEulerAngleX; // Head is tilted up and down rotX degrees
        final double? rotY =
            face.headEulerAngleY; // Head is rotated to the right rotY degrees
        final double? rotZ =
            face.headEulerAngleZ; // Head is tilted sideways rotZ degrees
        printIfDebug('Bounding box: $boundingBox');
        printIfDebug('rotX: $rotX, rotY: $rotY, rotZ: $rotZ');
        // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
        // eyes, cheeks, and nose available):
        final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
        if (leftEar != null) {
          final Point<int> leftEarPos = leftEar.position;
          printIfDebug('Left ear position: $leftEarPos');
        }

        // If classification was enabled with FaceDetectorOptions:
        if (face.smilingProbability != null) {
          final double? smileProb = face.smilingProbability;
          printIfDebug('Smiling probability: $smileProb');
        }

        // If face tracking was enabled with FaceDetectorOptions:
        if (face.trackingId != null) {
          final int? id = face.trackingId;
          printIfDebug('Face id: $id');
        }
        face.landmarks.forEach((landmarkType, landmark) {
          final point = landmark?.position;
          printIfDebug('Landmark: $landmark Type: $landmarkType Position: $point');
        });
      }
    } else {
      String text = 'Face meshes found 2: ${meshes.length}\n\n';
      for (final mesh in meshes) {
        text += 'face bounding box: ${mesh.boundingBox}\n\n';
      }
      _text = text;
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

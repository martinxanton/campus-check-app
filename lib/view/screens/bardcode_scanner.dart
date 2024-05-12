import 'dart:convert';
import 'package:campus_check_app/models/student_model.dart';
import 'package:campus_check_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:campus_check_app/view/components/camera.dart';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({super.key});

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraView(customPaint: _customPaint, onImage: _processImage),
      ],
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    final barcodes = await _barcodeScanner.processImage(inputImage);
    if (!_canProcess) return;
    if (_isBusy) return;

    if (barcodes.isNotEmpty) {
      BarcodeType type;
      for (Barcode barcode in barcodes) {
        type = barcode.type;
        if (type == BarcodeType.text) {
          // ignore: avoid_print
          print('Barcode: ${barcode.rawValue}');
          setState(() {
            _isBusy = true;
          });
          if (_isBusy) {
            final barcodeText = barcode.rawValue;
            _pauseBarcodeDetection();
            if (barcodeText?.length != 8) {
              _resumeBarcodeDetection();
              return;
            }
            String responseJson = '';
            // Simulación de petición a un servidor (API REST)
            if (barcodeText == '20200133') {
              responseJson =
                  await rootBundle.loadString('assets/json/20200133.json');
            } else if (barcodeText == '20200137') {
              responseJson =
                  await rootBundle.loadString('assets/json/20200137.json');
            } else if (barcodeText == '20200012') {
              responseJson =
                  await rootBundle.loadString('assets/json/20200012.json');
            } else if (barcodeText == '20200054') {
              responseJson =
                  await rootBundle.loadString('assets/json/20200054.json');
            } else if (barcodeText == '20200297') {
              responseJson =
                  await rootBundle.loadString('assets/json/20200297.json');
            } else {
              _resumeBarcodeDetection();
              return;
            }
            final userData = json.decode(responseJson);
            setState(() {
              Navigator.pushNamed(context, Routes.profile,
                  arguments: StudentModel(
                    code: userData['code'],
                    docID: userData['docID'],
                    name: userData['name'],
                    faculty: userData['faculty'],
                    career: userData['career'],
                    stateEnrollment: userData['stateEnrollment'],
                    semester: userData['semester'],
                    photoURL: userData['photoURL'],
                  )).then((_) {
                _resumeBarcodeDetection();
              });
            });
          }
        }
      }
    }
  }

  void _pauseBarcodeDetection() {
    setState(() {
      _isBusy = true;
      _canProcess = false;
      _barcodeScanner.close();
    });
  }

  void _resumeBarcodeDetection() {
    setState(() {
      _isBusy = false;
      _canProcess = true;
    });
  }
}

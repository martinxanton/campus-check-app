import 'package:campus_check_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:campus_check_app/screens/camera_view.dart';

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
      setState(() {
        _isBusy = true;
      });
      if (_isBusy) {
        final barcodeText =
            barcodes.map((barcode) => barcode.rawValue).join('\n');
        _pauseBarcodeDetection();
        setState(() {
          Navigator.pushNamed(context, Routes.profile,
              arguments: {'code': barcodeText}).then((_) {
            _resumeBarcodeDetection();
          });
        });
      }
    }
  }

  void _pauseBarcodeDetection() {
    setState(() {
      _isBusy = true;
      _canProcess = false;
    });
  }

  void _resumeBarcodeDetection() {
    setState(() {
      _isBusy = false;
      _canProcess = true;
    });
  }
}

import 'dart:convert';
import 'package:campus_check_app/models/student_model.dart';
import 'package:campus_check_app/routes/routes.dart';
import 'package:campus_check_app/services/storage_service.dart';
import 'package:campus_check_app/utils/utils.dart';
import 'package:campus_check_app/view/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:campus_check_app/view/components/camera.dart';
import 'package:http/http.dart' as http;

final StorageService _storageService = StorageService();

Future<Map<String, dynamic>?> fetchPersonData(String id, String token) async {
  final url = 'http://192.168.18.36:5050/api/v1/student/$id';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load person data');
    }
  } catch (e) {
    printIfDebug('Error fetching person data: $e');
    return null;
  }
}

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
            String id = barcodeText!.trim();

            if (id.isEmpty || id.length < 8) return;

            String token = await _storageService.getToken() ?? '';
            var personData = await fetchPersonData(id, token);
            if (mounted) {
              if (personData != null) {
                Navigator.pushNamed(context, Routes.profile,
                    arguments: StudentModel(
                      code: personData['student']['cod'],
                      docID: personData['person']['dni'],
                      name: personData['person']['firstName'],
                      faculty: personData['student']['faculty'],
                      career: personData['student']['career'],
                      stateEnrollment: 1,
                      semester: 0,
                      photoURL: personData['student']['image'],
                    )).then((_) {
                  _resumeBarcodeDetection();
                });
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DialogBox();
                  },
                ).then((_) {
                  _resumeBarcodeDetection();
                });
              }
            }
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
